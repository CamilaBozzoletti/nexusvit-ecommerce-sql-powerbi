USE nexusvit;

-- ==================================================================================================================
-- 1. REPORTS AND ANALYTICS
-- Purpose: Provide all operational and business reports required by management,
--          including daily sales, product analysis, inventory control, customer analysis,
--          replenishment tracking, and marketing mailing lists.
-- ==================================================================================================================

-- ******************************************************************************************************************
-- REPORT 1: DAILY SALES REPORT
-- Description: Lists all paid sales for a specific date, including customer and product details with totals.
-- ******************************************************************************************************************

SELECT
pur.purchase_id,
pur.purchase_date,
c.customer_id,
c.first_name,
c.last_name,
c.city,
pi.product_id,
p.product_name,
pc.category_name,
pi.quantity,
pi.unit_price,
pi.quantity * pi.unit_price AS product_subtotal,
t.purchase_total
FROM purchase pur
INNER JOIN customer c ON pur.customer_id = c.customer_id
INNER JOIN purchase_item pi ON pur.purchase_id = pi.purchase_id
INNER JOIN product p ON pi.product_id = p.product_id
INNER JOIN product_category pc ON p.category_id = pc.category_id

-- Derived table to calculate the total value of each purchase.
-- The aggregation (SUM of quantity * unit_price) is performed separately at the purchase level
-- to obtain the purchase_total without losing the product-level detail in the main query.
-- This result is then joined back to the main dataset using purchase_id.

INNER JOIN (
	SELECT
    pi.purchase_id,
    SUM(pi.quantity * pi.unit_price) AS purchase_total
    FROM purchase_item pi
    GROUP BY pi.purchase_id
) t ON pur.purchase_id = t.purchase_id

WHERE DATE(pur.purchase_date) = '2025-10-25' AND pur.purchase_status_id = 1;


-- ******************************************************************************************************************
-- REPORT 2: PRODUCT SALES ANALYSIS
-- Description: Shows total quantity sold and total revenue per product, total quantity sold per category,
-- and a ranking of best-selling products for a specified period.
-- ******************************************************************************************************************

-- 2.1 Total quantity sold per product
SELECT
p.product_id,
p.product_name,
SUM(pi.quantity) AS total_quantity
FROM product p
INNER JOIN purchase_item pi ON p.product_id = pi.product_id
INNER JOIN purchase pur ON pi.purchase_id = pur.purchase_id
WHERE pur.purchase_status_id = 1 AND pur.purchase_date BETWEEN '2025-03-01' AND '2025-05-31'
GROUP BY p.product_id, p.product_name
ORDER BY p.product_id ASC;

-- 2.2 Total revenue per product
SELECT
p.product_id,
p.product_name,
SUM(pi.quantity * pi.unit_price) AS total_revenue
FROM product p
INNER JOIN purchase_item pi ON pi.product_id = p.product_id
INNER JOIN purchase pur ON pi.purchase_id = pur.purchase_id
WHERE pur.purchase_status_id = 1 AND pur.purchase_date BETWEEN '2025-03-01' AND '2025-05-31'
GROUP BY
p.product_id,
p.product_name
ORDER BY p.product_id ASC;

-- 2.3 Total quantity sold per category
SELECT
pc.category_id,
pc.category_name,
SUM(pi.quantity) AS total_quantity
FROM product_category pc
INNER JOIN product p ON pc.category_id = p.category_id
INNER JOIN purchase_item pi ON p.product_id = pi.product_id
INNER JOIN purchase pur ON pi.purchase_id = pur.purchase_id
WHERE purchase_status_id = 1 AND pur.purchase_date BETWEEN '2025-03-01' AND '2025-05-31'
GROUP BY
pc.category_id,
pc.category_name
ORDER BY pc.category_id ASC;

-- 2.4 Ranking of best-selling products
SELECT
product_totals.product_id,
product_totals.product_name,
product_totals.total_quantity,
RANK() OVER (ORDER BY total_quantity DESC) AS product_rank -- Assigns a ranking to each product based on total quantity sold, highest first
FROM (
-- Subquery: total quantity sold per product
	SELECT
    p.product_id,
	p.product_name,
	SUM(pi.quantity) AS total_quantity
	FROM product p
	INNER JOIN purchase_item pi ON p.product_id = pi.product_id
	INNER JOIN purchase pur ON pi.purchase_id = pur.purchase_id
	WHERE pur.purchase_status_id = 1 AND pur.purchase_date BETWEEN '2025-03-01' AND '2025-05-31'
	GROUP BY
    p.product_id,
    p.product_name
    ) AS product_totals
    ORDER BY product_rank ASC, product_id ASC;

-- ******************************************************************************************************************
-- REPORT 3: INVENTORY CONTROL
-- Description: Provides a complete overview of current stock levels, highlighting critical stock products,
-- and calculates the total value of inventory available (current stock × unit price) for a given point in time.
-- Includes:
-- 3.1 Products with current stock
-- 3.2 Products at or below their critical stock threshold
-- 3.3 Total inventory value
-- ******************************************************************************************************************

-- 3.1 Products with current stock
SELECT * 
FROM inventory_view;

-- 3.2 Products at or below their critical stock threshold.
SELECT *
FROM critical_stock_view;

-- 3.3 Total inventory value
-- Calculates the total monetary value of all available inventory
SELECT
SUM(iv.current_stock * p.current_price) AS total_inventory_value
FROM inventory_view iv
INNER JOIN product p ON iv.product_id = p.product_id;

-- ******************************************************************************************************************
-- REPORT 4: CUSTOMER ANALYSIS
-- Description: Provides insights into customer purchasing behavior, including total number of purchases,
-- total amount spent within a specified period, average ticket value per customer, and identification
-- of customers who have not made purchases in the last X months.
-- ******************************************************************************************************************

-- 4.1 Total number of purchases per customer
SELECT
c.customer_id,
c.first_name,
c.last_name,
COUNT(pur.purchase_id) AS total_purchases
FROM customer c
INNER JOIN purchase pur ON c.customer_id = pur.customer_id
WHERE pur.purchase_status_id = 1
GROUP BY
c.customer_id,
c.first_name,
c.last_name
ORDER BY c.customer_id ASC;

-- 4.2 Total amount spent per customer within a specified period
SELECT
c.customer_id,
c.first_name,
c.last_name,
SUM(pi.quantity * pi.unit_price) AS total_amount_spent
FROM customer c
INNER JOIN purchase pur ON c.customer_id = pur.customer_id
INNER JOIN purchase_item pi ON pur.purchase_id = pi.purchase_id
WHERE pur.purchase_status_id = 1 AND pur.purchase_date BETWEEN '2025-03-01' AND '2025-05-31'
GROUP BY
customer_id,
c.first_name,
c.last_name
ORDER BY c.customer_id ASC;

-- 4.3 Average ticket value per customer
SELECT
c.customer_id,
c.first_name,
c.last_name,
SUM(pi.quantity * pi.unit_price) / COUNT(pur.purchase_id) AS avg_ticket
FROM customer c
INNER JOIN purchase pur ON c.customer_id = pur.customer_id
INNER JOIN purchase_item pi ON pur.purchase_id = pi.purchase_id
WHERE pur.purchase_status_id = 1 AND pur.purchase_date BETWEEN '2025-03-01' AND '2025-05-31'
GROUP BY
customer_id,
c.first_name,
c.last_name
ORDER BY c.customer_id ASC;

-- 4.4 Customers with no purchases in the last 3 months
SELECT
c.customer_id,
c.first_name,
c.last_name
FROM customer c
WHERE NOT EXISTS (
	SELECT 1
    FROM purchase pur
    WHERE pur.customer_id = c.customer_id
    AND pur.purchase_status_id = 1
    AND pur.purchase_date BETWEEN '2025-08-01' AND '2025-10-31'
);

-- 4.5 Customers without recent paid purchases
-- Added for the dashboard to show clients without recent paid purchases, 
-- which is difficult to handle directly in Power BI.

SELECT
c.customer_id,
MAX(pur.purchase_date) AS last_purchase_date,
DATEDIFF('2025-10-25', MAX(pur.purchase_date)) AS days_inactive,
SUM(pi.quantity * pi.unit_price) AS total_revenue,
COUNT(pur.purchase_id) AS total_purchases
FROM customer c
INNER JOIN purchase pur ON c.customer_id = pur.customer_id
INNER JOIN purchase_item pi ON pur.purchase_id = pi.purchase_id
WHERE pur.purchase_status_id = 1
GROUP BY c.customer_id
HAVING DATEDIFF('2025-10-25', MAX(pur.purchase_date)) > 90 -- A customer is considered inactive if they have not made any paid purchases in the last 90 days
ORDER BY last_purchase_date ASC;

-- ******************************************************************************************************************
-- REPORT 5: REPLENISHMENT ANALYSIS
-- Description: Provides insights into product replenishments, including which products were restocked 
-- during a specified period, the supplier for each replenishment, the quantity and date of restocking, 
-- and the time between critical stock detection and effective replenishment.
-- ******************************************************************************************************************

-- 5.1 Products restocked within a specified period
SELECT
sr.replenishment_id,
sr.product_id,
p.product_name,
sr.replenishment_date
FROM stock_replenishment sr
INNER JOIN product p ON sr.product_id = p.product_id
WHERE sr.replenishment_date BETWEEN '2025-09-01' AND '2025-10-31'
ORDER BY sr.replenishment_id ASC;

-- 5.2 Supplier for each replenishment
SELECT
sr.replenishment_id,
p.product_name,
sr.supplier_id,
s.company_name,
sr.replenishment_date
FROM stock_replenishment sr
INNER JOIN product p ON sr.product_id = p.product_id
INNER JOIN supplier s ON sr.supplier_id = s.supplier_id
WHERE sr.replenishment_date BETWEEN '2025-09-01' AND '2025-10-31'
ORDER BY sr.replenishment_id ASC;

-- 5.3 Quantity and date of each replenishment
SELECT
sr.replenishment_id,
p.product_name,
sr.quantity_replenished,
sr.replenishment_date
FROM stock_replenishment sr
INNER JOIN product p ON sr.product_id = p.product_id
WHERE sr.replenishment_date BETWEEN '2025-09-01' AND '2025-10-31'
ORDER BY sr.replenishment_date ASC;

-- 5.4 Time between critical stock detection and replenishment
SELECT
sr.replenishment_id,
p.product_name,
sr.replenishment_date,
sr.stock_alert_date,
DATEDIFF(sr.replenishment_date, sr.stock_alert_date) AS days_to_replenish
FROM stock_replenishment sr
INNER JOIN product p ON sr.product_id = p.product_id
WHERE sr.replenishment_date BETWEEN '2025-09-01' AND '2025-10-31'
ORDER BY sr.replenishment_id ASC;

-- ******************************************************************************************************************
-- REPORT 6: CUSTOMER MAILING LIST
-- Description: Generates a contact list for marketing purposes, including customer name, email address,
-- and city, for customers who have made at least one paid purchase.
-- ******************************************************************************************************************

SELECT DISTINCT
c.customer_id,
c.first_name,
c.last_name,
c.email,
c.city
FROM customer c
INNER JOIN purchase pur ON c.customer_id = pur.customer_id
WHERE purchase_status_id = 1
ORDER BY customer_id ASC;

