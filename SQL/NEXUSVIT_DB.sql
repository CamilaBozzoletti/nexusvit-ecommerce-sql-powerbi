-- ==================================================================================================================
-- 1. DATABASE CREATION
-- Purpose: Create the database and set initial configurations
-- ==================================================================================================================

DROP DATABASE IF EXISTS nexusvit;
CREATE DATABASE nexusvit;
USE nexusvit;

-- ==================================================================================================================
-- 2. TABLES CREATION (DDL)
-- Purpose: Define all tables, constraints and primary/foreign keys
-- ==================================================================================================================

-- Table of product's categories
CREATE TABLE product_category(
category_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(100) NOT NULL,
category_description VARCHAR(500),

CONSTRAINT uq_category_name UNIQUE (category_name) -- Each category must have a unique name.
);

-- Table of products
CREATE TABLE product(
product_id INT AUTO_INCREMENT PRIMARY KEY,
category_id SMALLINT NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_description VARCHAR(500),
current_price DECIMAL(10,2) NOT NULL,
stock_threshold INT NOT NULL, -- Minimum acceptable quantity before needing replenishment.

CONSTRAINT uq_product_name_category
UNIQUE (category_id, product_name), -- Guarantees no two products have the same name in the same category

CONSTRAINT chk_stock_threshold
CHECK (stock_threshold >= 0), -- Ensures stock threshold is not negative.

CONSTRAINT fk_product_product_category
FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- Table of customer
CREATE TABLE customer(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
id_number VARCHAR(20) NOT NULL UNIQUE,
email VARCHAR(255),
phone VARCHAR(20),
address VARCHAR(500) NOT NULL,
city VARCHAR(50) NOT NULL,

CONSTRAINT chk_customer_contact
CHECK (email IS NOT NULL OR phone IS NOT NULL) -- Ensures no record exists without at least one contact method (email or phone).
);

-- Table of purchase status. Each record represents a possible status for a purchase.
CREATE TABLE purchase_status(
purchase_status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(100) NOT NULL UNIQUE -- Guarantees no two purchase statuses have the same name.
);

-- Table of payment methods
CREATE TABLE payment_method(
payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
method_name VARCHAR(100) NOT NULL UNIQUE,
method_active BOOLEAN NOT NULL DEFAULT TRUE
-- Indicates whether the payment method is currently active.
-- New payment methods are set to active by default to prevent accidental omissions.
);

-- Table of purchases
CREATE TABLE purchase(
purchase_id INT AUTO_INCREMENT PRIMARY KEY,
purchase_status_id INT NOT NULL,
payment_method_id INT NOT NULL,
customer_id INT NOT NULL,
purchase_date DATETIME NOT NULL,

CONSTRAINT fk_purchase_purchase_status
FOREIGN KEY (purchase_status_id) REFERENCES purchase_status(purchase_status_id),

CONSTRAINT fk_purchase_payment_method
FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id),

CONSTRAINT fk_purchase_customer
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Junction table linking purchases and products in a many-to-many relationship
CREATE TABLE purchase_item(
purchase_item_id INT AUTO_INCREMENT PRIMARY KEY,
purchase_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,

CONSTRAINT uq_purchase_product
UNIQUE (purchase_id, product_id), -- Prevents duplicate products within the same purchase.

CONSTRAINT chk_quantity_purchase
CHECK (quantity > 0), -- Prevents sales with zero or negative quantities.

CONSTRAINT fk_purchase_item_purchase
FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id)
ON DELETE CASCADE, -- Ensures that purchase items are automatically removed if the related purchase is deleted.

CONSTRAINT fk_purchase_item_product
FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Table of suppliers
CREATE TABLE supplier(
supplier_id INT AUTO_INCREMENT PRIMARY KEY,
company_name VARCHAR(100) NOT NULL,
tax_id VARCHAR(50) NOT NULL UNIQUE, -- Ensures each supplier has a unique identification number
email VARCHAR(255),
phone VARCHAR(20),

CONSTRAINT chk_supplier_contact
CHECK (email IS NOT NULL OR phone IS NOT NULL)

);

-- Junction table linking suppliers and products in a many-to-many relationship
CREATE TABLE product_supplier(
product_supplier_id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT NOT NULL,
supplier_id INT NOT NULL,

CONSTRAINT uq_product_supplier
UNIQUE (product_id, supplier_id), -- Prevents dupplicate product-supplier associations

CONSTRAINT fk_product_supplier_product
FOREIGN KEY (product_id) REFERENCES product(product_id)
ON DELETE CASCADE,

CONSTRAINT fk_product_supplier_supplier
FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
ON DELETE CASCADE
);

-- Table of stock replenishment
CREATE TABLE stock_replenishment(
replenishment_id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT NOT NULL,
supplier_id INT NOT NULL,
quantity_replenished INT NOT NULL,
stock_alert_date DATETIME NOT NULL,
replenishment_date DATETIME NOT NULL,
-- This table records completed stock replenishment events
-- Therefore, a replenishment date is always required

CONSTRAINT chk_quantity_replenished
CHECK (quantity_replenished > 0), -- Ensures that only positive replenishment quantities can be recorded

CONSTRAINT fk_stock_replenishment_product
FOREIGN KEY (product_id) REFERENCES product(product_id),

CONSTRAINT fk_stock_replenishment_supplier
FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- Table of stock_movements
CREATE TABLE stock_movement(
movement_id INT AUTO_INCREMENT PRIMARY KEY,
purchase_item_id INT,
replenishment_id INT,
quantity INT NOT NULL,
movement_date DATETIME NOT NULL,

CONSTRAINT chk_stock_movement_type -- Ensures each stock movement is either a purchase or a replenishment, never both
CHECK (purchase_item_id IS NOT NULL OR replenishment_id IS NOT NULL),

CONSTRAINT fk_stock_movement_purchase_item
FOREIGN KEY (purchase_item_id) REFERENCES purchase_item(purchase_item_id)
ON DELETE CASCADE,

CONSTRAINT fk_stock_movement_replenishment
FOREIGN KEY (replenishment_id) REFERENCES stock_replenishment(replenishment_id)
ON DELETE CASCADE
);

-- ==================================================================================================================
-- 3. TRIGGERS
-- Purpose: Automatically manage stock changes and enforce business rules
-- ==================================================================================================================

-- TRIGGER 1: Automatically decreases product stock when a purchase status changes to 'Paid'.
DELIMITER $$

CREATE TRIGGER tr_stock_decrease
AFTER UPDATE ON purchase
FOR EACH ROW
BEGIN
IF NEW.purchase_status_id = 1 AND OLD.purchase_status_id <> 1 THEN
-- Runs only when the purchase transitions to 'Paid', preventing duplicate stock movements if the purchase was already paid
INSERT INTO stock_movement (purchase_item_id, replenishment_id, quantity, movement_date)
SELECT
pi.purchase_item_id, -- Each product sold
NULL, -- No replenishment
-pi.quantity, -- Negative quantity to reduce stock
NOW() -- Use current timestamp because the stock movement occurs at the moment the purchase is paid, not when the purchase was created
FROM purchase_item pi
WHERE pi.purchase_id = NEW.purchase_id; 
END IF;

END$$
DELIMITER ;

-- TRIGGER 2: Increases stock automatically when a new replenishment is recorded.
DELIMITER $$

CREATE TRIGGER tr_stock_increase
AFTER INSERT ON stock_replenishment
FOR EACH ROW
BEGIN
INSERT INTO stock_movement (purchase_item_id, replenishment_id, quantity, movement_date)
VALUES (NULL, NEW.replenishment_id, NEW.quantity_replenished, NEW.replenishment_date);

END$$
DELIMITER ;

-- ==================================================================================================================
-- 4. VIEWS
-- Purpose: Generate virtual tables for inventory management and BI analysis
-- ==================================================================================================================

-- VIEW 1: Inventory view
-- Show current stock of each product based on all stock movements (sales and replenishments)
-- including products without movements (stock =  0)

CREATE OR REPLACE VIEW inventory_view AS
SELECT
	p.product_id,
	p.product_name,
	pc.category_name,
	COALESCE(SUM(sm_total.quantity), 0) AS current_stock, -- Use COALESCE to show 0 for products without movements instead of NULL
	p.stock_threshold
FROM product AS p

-- Subquery: unifiy all stock movements from different sources into a single temporary table
LEFT JOIN (
-- Movements from sales (negative quantities)
	SELECT
		pi.product_id,
		sm.quantity
	FROM purchase_item AS pi
	INNER JOIN stock_movement AS sm ON pi.purchase_item_id = sm.purchase_item_id
	UNION ALL
-- Movements from replenishments (positive quantities)
	SELECT
		sr.product_id,
		sm.quantity
	FROM stock_replenishment AS sr
	INNER JOIN stock_movement AS sm ON sr.replenishment_id = sm.replenishment_id)
AS sm_total ON p.product_id = sm_total.product_id

-- Join to product_category to get the category name
LEFT JOIN product_category AS pc ON p.category_id = pc.category_id
-- Group results by product and related columns
GROUP BY
p.product_id,
p.product_name,
pc.category_name,
p.stock_threshold;

-- VIEW 2: Critical Stock View
-- Lists products whose current stock is at or below the critical threshold,
-- based on all stock movements from sales and replenishments.
-- Includes products that have zero stock.

CREATE OR REPLACE VIEW critical_stock_view AS
SELECT
	p.product_id,
	p.product_name,
	pc.category_name,
	COALESCE(SUM(sm_total.quantity), 0) AS current_stock,
	p.stock_threshold
FROM product AS p
LEFT JOIN (
	SELECT
		pi.product_id,
		sm.quantity
	FROM purchase_item AS pi
	INNER JOIN stock_movement AS sm ON pi.purchase_item_id = sm.purchase_item_id
	UNION ALL
	SELECT
		sr.product_id,
		sm.quantity
	FROM stock_replenishment AS sr
	INNER JOIN stock_movement AS sm ON sr.replenishment_id = sm.replenishment_id)
AS sm_total ON p.product_id = sm_total.product_id
LEFT JOIN product_category AS pc ON p.category_id = pc.category_id
GROUP BY
p.product_id,
p.product_name,
pc.category_name,
p.stock_threshold
HAVING COALESCE(SUM(sm_total.quantity), 0) <= p.stock_threshold;
-- Applies the filter for low-stock products,
-- alerting for items at or below their critical stock threshold.


