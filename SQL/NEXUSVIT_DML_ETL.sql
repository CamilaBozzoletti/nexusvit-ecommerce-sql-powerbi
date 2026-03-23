USE nexusvit;

-- ==================================================================================================================
-- 5. DATA MANIPULATION (DML)
-- Purpose: Populate tables, perform data cleaning operations (ETL), and simulate transactional activity.
-- ==================================================================================================================

-- ------------------------------------------------------------------------------------------------------------------
-- 5.1 DATA POPULATION
-- Insert simulated records into all tables to create a functional dataset,
-- including controlled data quality issues for ETL and cleaning practice.
-- ------------------------------------------------------------------------------------------------------------------

-- POPULATE: product_category (Master Data)
-- 6 product categories with business context
INSERT INTO product_category(category_name, category_description)
VALUES
('Sportswear', 'Clothing designed for workouts and sports, offering comfort and flexibility'),
('Training Shoes', NULL),	
('Fitness Accessories', 'Tools and equipment to enhance workouts, stretching, and fitness performance'),
('Personal Care & Wellness', 'Products for self-care, relaxation, and overall well-being'),
('Fitness Technology', 'Smart devices and gadgets that track health, activity and performance'),
('Home Workout Equipment', 'Equipment for strength and cardio training at home, including weights and mats')
;

-- POPULATE: product (Master Data)
-- 30 products across 6 categories
INSERT INTO product(category_id, product_name, product_description, current_price, stock_threshold)
VALUES
(1, "Flex Sports T-Shirt", "Breathable t-shirt for intense workouts", 25, 30),
(1, "Power Leggings", "Compression leggings with quick-dry fabric", 40, 30),
(1, "Energy Sports Top", "Medium-support top with adjustable straps", 20, 30),
(1, "RunFast Shorts", "Lightweight shorts for running and cardio", 22, 30),
(1, "EcoFit T-Shirt", NULL, 28, 30),
(1, "Motion Leggings", "High-stretch leggings perfect for yoga", 35, 30),
(2, "SpeedRunner Sneakers", "Running shoes with enhanced cushioning", 80, 15),
(2, "TrainPro Sneakers", "Training shoes for strength workouts", 75, 15),
(2, "YogaFlow Sneakers", "Flexible shoes for yoga and pilates", 65, 15),
(2, "AirMove Sneakers", "Lightweight shoes for cardio and running", 90, 15),
(2, "CrossStep Sneakers", "Multi-purpose gym shoes", 85, 15),
(3, "HydroMax Water Bottle", "BPA-free sports bottle, 750ml", 15, 25),
(3, "StretchPro Resistance Band", "Band for stretching and toning", 12, 25),
(3, "ZenMat Yoga Mat", "Non-slip 6mm yoga mat", 30, 25),
(3, "GripFit Training Gloves", "Gloves with reinforcement for gym workouts", 18, 25),
(3, "RelaxRoll Foam Roller", "Roller for stretching and muscle relaxation", 25, 25),
(4, "Lavender Calm Essential Oil", NULL, 12, 20),
(4, "Silk Hand Cream", "Moisturizing cream for soft, healthy hands", 18, 20),
(4, "Wellness Scented Candle", "Soy candle with eucalyptus aroma", 15, 20),
(4, "Mint Fresh Essential Oil", "Oil to revitalize and stimulate the senses", 12, 20),
(5, "FitTrack Smartwatch", "Smartwatch with activity tracking", 120, 10),
(5, "SoundMove Sports Earbuds", "Sweat-resistant Bluetooth earbuds", 60, 10),
(5, "SleepWell Sleep Monitor", "Device for tracking sleep, activity, and health", 80, 10),
(5, "YogaTime Smartwatch", "Smartwatch with yoga and meditation features", 110, 10),
(6, "FlexWeight Adjustable Dumbbells", NULL, 50, 12),
(6, "PowerBell Kettlebell", "8kg cast iron kettlebell", 35, 12),
(6, "Balance Board", "Board for core stability and balance training", 30, 12),
(6, "StrongBand Resistance Band", "Band for strength training and stretching", 15, 12),
(6, "KettFlex Kettlebell", "12kg kettlebell ideal for HIIT workouts", 40, 12),
(6, "Ab Wheel", "Wheel for core strengthening exercises at home", 22, 12);

-- POPULATE: customer (Master Data)
-- 60 customers from Canada, USA, UK, Australia, and Latin America

INSERT INTO customer(first_name, last_name, id_number, email, phone, address, city)
VALUES
('Emily', 'Smith', 'CUST001', 'emily.smith@email.com', '1 416 555 1234', '123 Maple St', 'Toronto'),
('James', 'Johnson', 'CUST002', 'james.johnson@email.com', '1 604 555 2345', '456 Oak Ave', 'Vancouver'),
('Olivia', 'Brown', 'CUST003', 'oliviabrown@email.com', '1 514 555 3456', '789 Pine Rd', 'Montreal'),
('Liam', 'Wilson', 'CUST004', 'liam.wilson@email', '1 403 555 4567', '321 Cedar Blvd', 'Calgary'),
('Sophia', 'Taylor', 'CUST005', 'sophia.taylor@email.com', '416-555-56A78', '654 Spruce Dr', 'Toronto'),
('William', 'Evans', 'CUST006', 'william.evans@email.com', '1 647 555 6789', '987 Birch Lane', 'Ottawa'),
('Isabella', 'Moore', 'CUST007', 'isabella.moore@email.com', '1 416 555 7890', '159 Elm St', 'Toronto'),
('Mason', 'Thomas', 'CUST008', 'mason.thomas@email.com', '1 604 555 8901', '753 Cedar Ave', 'Vancouver'),
('Mia', 'Harris', 'CUST009', 'mi@harris.com', '1 514 555 9012', '852 Oak Rd', 'Montreal'),
('Ethan', 'Martin', 'CUST010', 'ethan.martin@email.com', '1 403 555 0123', '951 Willow Blvd', 'Calgary'),
('Charlotte', 'Lee', 'CUST011', 'charlotte.lee@email.com', '647-555-3456', '357 Aspen St', 'Ottawa'),
('Alexander', 'Clark', 'CUST012', 'alex.clark@email.com', '1 416 555 2345', '246 Pine Ave', 'Toronto'),
('Amelia', 'Walker', 'CUST013', 'amelia.walker@email', '1 604 555 5678', '135 Maple Rd', 'Vancouver'),
('Benjamin', 'Hall', 'CUST014', 'benjamin.hall@email.com', '1 514 555 6789', '864 Birch Blvd', 'Montreal'),
('Harper', 'Allen', 'CUST015', 'harper.allen@email.com', '1 403 555 7890', '975 Cedar St', 'Calgary'),
('Daniel', 'Young', 'CUST016', 'daniel.young@email.com', '416-555-8901', '159 Oak Rd', 'Toronto'),
('Evelyn', 'Hernandez', 'CUST017', 'evelyn.hernandez@email.com', '1 647 555 9012', '753 Pine Blvd', 'Ottawa'),
('Logan', 'King', 'CUST018', 'logan.king@email.com', '1 416 555 0123', '357 Spruce St', 'Toronto'),
('Abigail', 'Wright', 'CUST019', 'abigail.wright@email.com', '1 604 555 1234', '246 Maple Ave', 'Vancouver'),
('Jacob', 'Lopez', 'CUST020', 'jacob.lopez@email.com', '1 514 555 2345', '135 Cedar Rd', 'Montreal'),
('Sofia', 'Gonzalez', 'CUST021', 'sofia.gonzalez@email.com', '1 403 555 3456', '864 Oak Blvd', 'Calgary'),
('Matthew', 'Perez', 'CUST022', 'matthew.perez@email.com', '416-555-4567', '975 Willow St', 'Toronto'),
('Lily', 'Sanchez', 'CUST023', 'lily.sanchez@email.com', '1 647 555 5678', '159 Birch Ave', 'Ottawa'),
('Ryan', 'Robinson', 'CUST024', 'ryan.robinson@email.com', '1 416 555 6789', '753 Spruce Rd', 'Toronto'),
('Chloe', 'Scott', 'CUST025', 'chloe.scott@email.com', '1 604 555 7890', '357 Maple Blvd', 'Vancouver'),
('Noah', 'Adams', 'CUST026', 'noah.adams@email.com', '1 514 555 8901', '246 Cedar St', 'Montreal'),
('Grace', 'Baker', 'CUST027', 'grace.baker@email.com', '1 403 555 9012', '135 Oak Rd', 'Calgary'),
('Lucas', 'Gonzalez', 'CUST028', 'lucas.gonzalez@email.com', '416-555-0123', '864 Willow Ave', 'Toronto'),
('Victoria', 'Perez', 'CUST029', 'victoria.perez@email.com', '1 647 555 1234', '975 Birch Blvd', 'Ottawa'),
('Alexander', 'Martinez', 'CUST030', 'alex.martinez@email.com', '1 416 555 2345', '159 Spruce St', 'Toronto'),
('Oliver', 'White', 'CUST031', 'oliver.white@com', '1 212 555 1234', '123 Madison Ave', 'New York'),
('Emma', 'Harris', 'CUST032', 'emma.harris@email.com', '1 310 555 2345', '456 Sunset Blvd', 'Los Angeles'),
('Mason', 'Clark', 'CUST033', 'mason.clark@email.com', '1 312 555 3456', '789 Lake St', 'Chicago'),
('Ava', 'Lewis', 'CUST034', 'ava.lewis@email.com', '1 305 555 4567', '321 Ocean Dr', 'Miami'),
('Lucas', 'Walker', 'CUST035', 'lucas.walker@email.com', '1 213 555 5678', '654 Palm Ave', 'Los Angeles'),
('Amelia', 'Roberts', 'CUST036', 'amelia.roberts@email.com', '1 212 555 6789', '987 Fifth Ave', 'New York'),
('Ethan', 'Turner', 'CUST037', 'ethan.turner@email.com', '1 312 555 7890', '159 Lake Shore Dr', 'Chicago'),
('Harper', 'Campbell', 'CUST038', 'harper.campbell@email.com', '1 305 555 8901', '753 Ocean Blvd', 'Miami'),
('Oliver', 'Hughes', 'CUST039', 'oliver.hughes@email.com', '44 20 5555 1234', '10 Downing St', 'London'),
('Charlotte', 'Adams', 'CUST040', 'charlotte.adams@email.com', '44 161 555 2345', '22 King St', 'Manchester'),
('William', 'Scott', 'CUST041', 'william.scott@email.com', '44 121 555 3456', '33 Queen Rd', 'Birmingham'),
('Jack', 'Johnson', 'CUST042', 'jack.johnson@email.com', '61 2 5555 1234', '100 George St', 'Sydney'),
('Chloe', 'Williams', 'CUST043', 'chloe.williams@email.com', '61 3 5555 2345', '200 Collins Ave', 'Melbourne'),
('Camila', 'Torres', 'CUST044', 'camila.torres@email.com', '51 1 555-1234', '123 Lima St', 'Lima'),
('Diego', 'Ramirez', 'CUST045', 'diego.ramirez@email.com', '51 1 555-2345', '456 Miraflores Ave', 'Lima'),
('Sofía', 'González', 'CUST046', 'sofia.gonzalez@email.com', '54 11 5555 1234', '789 Palermo St', 'Buenos Aires'),
('Juan', 'Fernández', 'CUST047', 'juan.fernandez@email.com', '54 11 5555 2345', '321 Recoleta Ave', 'Buenos Aires'),
('Lucas', 'Silva', 'CUST048', 'lucas.silva@email.com', '55 11 5555 1234', '100 Paulista Ave', 'São Paulo'),
('Lily', 'Brown', 'CUST049', 'lily.brown@email.com', '1 416 555 3456', '852 Elm St', 'Toronto'),
('Noah', 'Wilson', 'CUST050', 'noah.wilson@email.com', '1 604 555 4567', '357 Pine Rd', 'Vancouver'),
('Grace', 'Johnson', 'CUST051', 'grace.johnson@email.com', '1 514 555 5678', '246 Oak Blvd', 'Montreal'),
('Liam', 'Smith', 'CUST052', 'liam.smith@email.com', '1 403 555 6789', '135 Maple St', 'Calgary'),
('Abigail', 'Brown', 'CUST053', 'abigail.brown@email.com', '416-555-7#90', '864 Birch Rd', 'Toronto'),
('Matthew', 'Davis', 'CUST054', 'matthew.davis@email.com', '1 647 555 8901', '975 Cedar Blvd', 'Ottawa'),
('Evelyn', 'Miller', 'CUST055', 'evelyn.miller@email.com', '1 416 555 9012', '159 Spruce Ave', 'Toronto'),
('Jacob', 'Moore', 'CUST056', 'jacob.moore@email.com', '1 604 555 0123', '753 Maple Rd', 'Vancouver'),
('Victoria', 'Taylor', 'CUST057', 'victoria.taylor@email.com', '1 514 555 1234', '357 Cedar St', 'Montreal'),
('Lucas', 'Anderson', 'CUST058', 'lucas.anderson@email.com', '1 403 555 2345', '246 Oak Rd', 'Calgary'),
('Emma', 'Thomas', 'CUST059', 'emma.thomas@email.com', '416-555-3456', '135 Willow Ave', 'Toronto'),
('Benjamin', 'Jackson', 'CUST060', 'benjamin.jackson@email.com', '1 647 555 4567', '864 Birch Blvd', 'Ottawa');

-- POPULATE: purchase_status (Master Data)
-- 3 purchase statuses
INSERT INTO purchase_status(status_name)
VALUES
('Paid'),
('Pending'),
('Cancelled');

-- POPULATE: payment_method (Master Data)
-- 5 payment methods
-- Crypto payment is marked as inactive pending implementation
INSERT INTO payment_method(method_name, method_active)
VALUES
('Credit Card', TRUE),
('Debit Card', TRUE),
('Digital Wallet', TRUE),
('Bank Transfer', TRUE),
('Crypto Payment', FALSE);


-- POPULATE: purchase (Transactional Data)
-- 100 purchase transactions throughout 2025 from 60 customers
INSERT INTO purchase(purchase_status_id, payment_method_id, customer_id, purchase_date)
VALUES
(2, 1, 1, '2025-01-03 10:15:00'),
(2, 1, 2, '2025-01-04 11:25:00'),
(2, 2, 3, '2025-01-05 14:10:00'),
(2, 1, 4, '2025-01-07 09:40:00'),
(2, 3, 5, '2025-01-10 17:05:00'),
(2, 1, 6, '2025-01-12 08:55:00'),
(2, 2, 7, '2025-01-15 12:30:00'),
(2, 1, 8, '2025-01-18 16:20:00'),
(2, 3, 9, '2025-01-20 10:50:00'),
(2, 1, 10, '2025-01-25 13:15:00'),
(2, 1, 11, '2025-02-01 09:45:00'),
(2, 2, 12, '2025-02-02 11:30:00'),
(2, 1, 13, '2025-02-05 15:05:00'),
(2, 3, 14, '2025-02-07 17:50:00'),
(2, 1, 15, '2025-02-10 08:25:00'),
(2, 2, 16, '2025-02-12 14:40:00'),
(2, 1, 17, '2025-02-15 10:15:00'),
(2, 3, 18, '2025-02-18 16:55:00'),
(2, 1, 19, '2025-02-20 09:05:00'),
(2, 2, 20, '2025-02-22 12:40:00'),
(2, 1, 21, '2025-03-01 08:30:00'),
(2, 3, 22, '2025-03-03 13:25:00'),
(2, 1, 23, '2025-03-05 15:55:00'),
(2, 2, 24, '2025-03-08 09:15:00'),
(2, 1, 25, '2025-03-10 11:45:00'),
(2, 3, 26, '2025-03-12 14:10:00'),
(2, 1, 27, '2025-03-15 08:50:00'),
(2, 2, 28, '2025-03-18 16:20:00'),
(2, 1, 29, '2025-03-20 10:30:00'),
(2, 3, 30, '2025-03-22 12:55:00'),
(2, 1, 1, '2025-04-01 09:10:00'),
(2, 2, 4, '2025-04-03 14:05:00'),
(2, 1, 5, '2025-04-05 10:40:00'),
(2, 3, 6, '2025-04-07 15:30:00'),
(2, 1, 2, '2025-04-10 08:50:00'),
(2, 1, 2, '2025-04-10 08:50:00'),
(2, 1, 7, '2025-04-12 12:20:00'),
(2, 2, 8, '2025-04-15 16:05:00'),
(2, 1, 9, '2025-04-18 09:50:00'),
(2, 3, 10, '2025-04-20 13:35:00'),
(2, 1, 11, '2025-05-01 08:15:00'),
(2, 2, 12, '2025-05-03 11:45:00'),
(2, 1, 13, '2025-05-06 14:30:00'),
(2, 3, 14, '2025-05-09 09:20:00'),
(2, 1, 15, '2025-05-12 12:05:00'),
(2, 2, 16, '2025-05-15 16:10:00'),
(2, 1, 17, '2025-05-18 08:55:00'),
(2, 3, 18, '2025-05-20 14:45:00'),
(2, 1, 19, '2025-05-23 09:30:00'),
(2, 2, 20, '2025-05-25 13:50:00'),
(2, 1, 21, '2025-06-01 08:10:00'),
(2, 3, 22, '2025-06-03 12:25:00'),
(2, 1, 23, '2025-06-06 15:40:00'),
(2, 2, 24, '2025-06-09 09:20:00'),
(2, 1, 25, '2025-06-12 11:50:00'),
(2, 3, 26, '2025-06-15 14:35:00'),
(2, 1, 27, '2025-06-18 08:40:00'),
(2, 2, 28, '2025-06-20 12:55:00'),
(2, 1, 29, '2025-06-23 15:05:00'),
(2, 3, 30, '2025-06-25 09:15:00'),
(2, 1, 31, '2025-07-01 08:50:00'),
(2, 2, 32, '2025-07-03 12:10:00'),
(2, 1, 33, '2025-07-06 14:40:00'),
(2, 3, 34, '2025-07-09 09:25:00'),
(2, 1, 35, '2025-07-12 11:55:00'),
(2, 2, 36, '2025-07-15 15:30:00'),
(2, 1, 37, '2025-07-18 08:05:00'),
(2, 3, 38, '2025-07-20 12:50:00'),
(2, 1, 39, '2025-07-23 14:20:00'),
(2, 2, 40, '2025-07-25 09:10:00'),
(2, 4, 41, '2025-08-01 10:00:00'),
(2, 1, 42, '2025-08-03 13:35:00'),
(2, 1, 43, '2025-08-05 09:45:00'),
(2, 3, 44, '2025-08-07 12:55:00'),
(2, 1, 45, '2025-08-10 08:30:00'),
(2, 2, 46, '2025-08-12 11:50:00'),
(2, 1, 47, '2025-08-15 14:15:00'),
(2, 3, 48, '2025-08-18 09:05:00'),
(2, 1, 49, '2025-08-20 12:40:00'),
(2, 2, 50, '2025-08-22 15:25:00'),
(2, 1, 51, '2025-09-01 08:20:00'),
(2, 3, 52, '2025-09-03 12:10:00'),
(2, 1, 53, '2025-09-06 14:50:00'),
(2, 2, 54, '2025-09-09 09:35:00'),
(2, 1, 55, '2025-09-12 11:55:00'),
(2, 3, 56, '2025-09-15 15:10:00'),
(2, 1, 57, '2025-09-18 08:50:00'),
(2, 2, 58, '2025-09-20 12:25:00'),
(2, 1, 59, '2025-09-23 14:45:00'),
(2, 3, 60, '2025-09-25 09:30:00'),
(2, 1, 1, '2025-10-01 08:15:00'),
(2, 2, 2, '2025-10-03 12:05:00'),
(2, 1, 3, '2025-10-06 14:40:00'),
(2, 3, 4, '2025-10-09 09:20:00'),
(2, 1, 5, '2025-10-12 11:55:00'),
(2, 2, 6, '2025-10-15 15:35:00'),
(2, 1, 7, '2025-10-18 08:50:00'),
(2, 3, 8, '2025-10-20 12:30:00'),
(2, 1, 9, '2025-10-25 14:10:00'),
(2, 2, 10, '2025-10-25 18:05:00');

-- POPULATE: purchase_item (Transactional Data)
-- Items included in each purchase.
-- In real systems this table is populated automatically by the backend when a purchase is created.
INSERT INTO purchase_item(purchase_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 25),
(1, 12, 1, 15),
(2, 7, 1, 80),
(2, 13, 1, 12),
(3, 3, 1, 20),
(3, 14, 1, 30),
(4, 2, 1, 40),
(4, 15, 2, 18),
(5, 21, 1, 120),
(5, 22, 1, 60),
(6, 4, 1, 22),
(6, 12, 2, 15),
(7, 8, 1, 75),
(7, 15, 1, 18),
(8, 5, 1, 28),
(8, 13, 1, 12),
(9, 6, 1, 35),
(9, 14, 1, 30),
(10, 25, 1, 50),
(10, 15, 1, 18),
(11, 9, 1, 65),
(11, 12, 1, 15),
(12, 10, 1, 90),
(12, 13, 2, 12),
(13, 21, 1, 120),
(13, 22, 1, 60),
(14, 4, 1, 22),
(14, 12, 1, 15),
(15, 3, 1, 20),
(15, 14, 1, 30),
(16, 26, 1, 35),
(16, 15, 1, 18),
(17, 27, 1, 30),
(17, 12, 1, 15),
(18, 2, 1, 40),
(18, 13, 1, 12),
(19, 1, 1, 25),
(19, 12, 1, 15),
(20, 7, 1, 80),
(20, 15, 1, 18),
(21, 3, 1, 20),
(21, 14, 1, 30),
(22, 8, 1, 75),
(22, 13, 1, 12),
(23, 21, 1, 120),
(23, 22, 1, 60),
(24, 5, 1, 28),
(24, 12, 1, 15),
(25, 6, 1, 35),
(25, 14, 1, 30),
(26, 26, 1, 35),
(26, 15, 1, 18),
(27, 27, 1, 30),
(27, 12, 1, 15),
(28, 2, 1, 40),
(28, 13, 1, 12),
(29, 1, 1, 25),
(29, 12, 1, 15),
(30, 7, 1, 80),
(30, 15, 1, 18),
(35, 1, 1, 25),
(35, 12, 1, 15),
(36, 7, 1, 80),
(36, 13, 1, 12),
(37, 3, 1, 20),
(37, 14, 1, 30),
(38, 2, 1, 40),
(38, 15, 1, 18),
(39, 21, 1, 120),
(39, 22, 1, 60),
(40, 4, 1, 22),
(40, 12, 1, 15),
(41, 8, 1, 75),
(41, 13, 1, 12),
(42, 5, 1, 28),
(42, 12, 1, 15),
(43, 6, 1, 35),
(43, 14, 1, 30),
(44, 25, 1, 50),
(44, 15, 1, 18),
(45, 9, 1, 65),
(45, 12, 1, 15),
(46, 10, 1, 90),
(46, 13, 1, 12),
(47, 21, 1, 120),
(47, 22, 1, 60),
(48, 4, 1, 22),
(48, 12, 1, 15),
(49, 3, 1, 20),
(49, 14, 1, 30),
(50, 26, 1, 35),
(50, 15, 1, 18),
(51, 27, 1, 30),
(51, 12, 1, 15),
(52, 2, 1, 40),
(52, 13, 1, 12),
(53, 1, 1, 25),
(53, 12, 1, 15),
(54, 7, 1, 80),
(54, 15, 1, 18),
(55, 3, 1, 20),
(55, 14, 1, 30),
(56, 8, 1, 75),
(56, 13, 1, 12),
(57, 21, 1, 120),
(57, 22, 1, 60),
(58, 5, 1, 28),
(58, 12, 1, 15),
(59, 6, 1, 35),
(59, 14, 1, 30),
(60, 26, 1, 35),
(60, 15, 1, 18),
(61, 1, 1, 25.75),
(61, 12, 1, 15.45),
(62, 7, 1, 82.4),
(62, 13, 1, 12),
(63, 3, 1, 20),
(63, 14, 1, 30.9),
(64, 2, 1, 41.2),
(64, 15, 1, 18),
(65, 21, 1, 123.6),
(65, 22, 1, 61.8),
(66, 4, 1, 22),
(66, 12, 1, 15.45),
(67, 8, 1, 75),
(67, 13, 1, 12),
(68, 5, 1, 28),
(68, 12, 1, 15.45),
(69, 6, 1, 35),
(69, 14, 1, 30.9),
(70, 26, 1, 36.05),
(70, 15, 1, 18),
(73, 1, 1, 25.75),
(73, 12, 1, 15.45),
(74, 7, 1, 82.4),
(74, 13, 1, 12),
(75, 3, 1, 20),
(75, 14, 1, 30.9),
(76, 2, 1, 41.2),
(76, 15, 1, 18),
(77, 21, 1, 123.6),
(77, 22, 1, 61.8),
(78, 4, 1, 22),
(78, 12, 1, 15.45),
(79, 8, 1, 75),
(79, 13, 1, 12),
(80, 5, 1, 28),
(80, 12, 1, 15.45),
(81, 6, 1, 35),
(81, 14, 1, 30.9),
(82, 26, 1, 36.05),
(82, 15, 1, 18),
(83, 27, 1, 30),
(83, 12, 1, 15.45),
(84, 2, 1, 41.2),
(84, 13, 1, 12),
(85, 1, 1, 25.75),
(85, 12, 1, 15.45),
(86, 7, 1, 82.4),
(86, 15, 1, 18),
(87, 3, 1, 20),
(87, 14, 1, 30.9),
(88, 8, 1, 75),
(88, 13, 1, 12),
(89, 21, 1, 123.6),
(89, 22, 1, 61.8),
(90, 5, 1, 28),
(90, 12, 1, 15.45),
(91, 1, 1, 25.75),
(91, 12, 1, 15.45),
(92, 7, 1, 82.4),
(92, 13, 1, 12),
(93, 3, 1, 20),
(93, 14, 1, 30.9),
(94, 1, 1, 21.89),
(94, 12, 1, 13.13),
(95, 7, 1, 70.04),
(95, 14, 1, 26.27),
(96, 21, 1, 105.06),
(96, 22, 1, 52.53),
(97, 2, 1, 35.02),
(97, 12, 1, 13.13),
(98, 7, 1, 70.04),
(98, 13, 1, 10.2),
(99, 3, 1, 17),
(99, 14, 1, 26.27),
(100, 21, 1, 105.06),
(100, 22, 1, 52.53),
(100, 12, 1, 13.13),
(100, 15, 1, 15.3);

-- POPULATE: supplier (Master Data)
-- 6 suppliers representing companies providing products
INSERT INTO supplier(company_name, tax_id, email, phone)
VALUES
('NorthPeak Sports Supply', 'SUPP001', 'contact@northpeak.com', '1 604 555 1101'),
('ActiveCore Equipment', 'SUPP002', 'sales@activecore.com', '1 416 555 2202'),
('PureBalance Wellness', 'SUPP003', 'info@purebalance.com', '44 20 5555 3303'),
('MotionTech Gear', 'SUPP004', 'support@motiontech.com', '1 212 555 4404'),
('VitalEdge Distributors', 'SUPP005', 'sales@vitaledge.com', '61 2 5555 5505'),
('GreenFlex Fitness', 'SUPP006', 'hello@greenflex.com', '55 11 5555 6606');

-- POPULATE: product_supplier (Junction Table)
-- 50 records linking products to their suppliers
INSERT INTO product_supplier(product_id, supplier_id)
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3),
(3, 4),
(4, 4),
(4, 5),
(5, 5),
(5, 6),
(6, 6),
(6, 1),
(7, 1),
(7, 3),
(8, 2),
(8, 4),
(9, 3),
(9, 5),
(10, 4),
(10, 6),
(11, 5),
(11, 1),
(12, 6),
(12, 2),
(13, 1),
(13, 4),
(14, 2),
(14, 5),
(15, 3),
(15, 6),
(16, 4),
(16, 1),
(17, 5),
(17, 2),
(18, 6),
(18, 3),
(19, 1),
(19, 5),
(20, 2),
(20, 6),
(21, 3),
(22, 4),
(23, 5),
(24, 6),
(25, 1),
(26, 2),
(27, 3),
(28, 4),
(29, 5),
(30, 6);

-- POPULATE: stock_replenishment (Transactional Data)
-- Records of stock replenishments throughout 2025
-- Each insert automatically increases stock through TRIGGER 2
INSERT INTO stock_replenishment(product_id, supplier_id, quantity_replenished, stock_alert_date, replenishment_date)
VALUES
(1, 1, 120, '2025-02-10', '2025-02-15'),
(2, 1, 100, '2025-03-05', '2025-03-10'),
(3, 2, 90, '2025-03-18', '2025-03-25'),
(4, 2, 80, '2025-04-02', '2025-04-08'),
(5, 1, 70, '2025-04-15', '2025-04-20'),
(6, 3, 75, '2025-05-01', '2025-05-05'),
(7, 4, 60, '2025-05-10', '2025-05-15'),
(8, 4, 55, '2025-05-22', '2025-05-28'),
(9, 5, 50, '2025-06-05', '2025-06-12'),
(10, 5, 45, '2025-06-15', '2025-06-20'),
(11, 4, 50, '2025-06-25', '2025-06-30'),
(12, 2, 150, '2025-07-10', '2025-07-12'),
(13, 2, 140, '2025-07-18', '2025-07-22'),
(14, 3, 120, '2025-08-02', '2025-08-08'),
(15, 3, 110, '2025-08-15', '2025-08-20'),
(16, 3, 100, '2025-09-01', '2025-09-05'),
(17, 6, 80, '2025-09-10', '2025-09-12'),
(18, 6, 70, '2025-09-20', '2025-09-18'),
(19, 6, 60, '2025-10-02', '2025-10-08'),
(21, 5, 40, '2025-10-10', '2026-01-10'),
(22, 4, 7, '2025-10-14', '2025-10-18'),
(23, 5, 35, '2025-10-25', '2025-10-28'),
(25, 3, 1, '2025-11-05', '2025-11-07'),
(26, 2, 10, '2025-11-07', '2025-11-10'),
(27, 3, 11, '2025-11-08', '2025-11-12');

-- Verify stock movements generated by TRIGGER 2
SELECT
sm.movement_id,
sr.replenishment_id,
sr.product_id,
p.product_name,
sm.quantity,
sm.movement_date
FROM stock_movement sm
INNER JOIN stock_replenishment sr ON sm.replenishment_id = sr.replenishment_id
INNER JOIN product p ON sr.product_id = p.product_id;

-- --------------------------------------------------------------------------------------------------
-- 5.2 SIMULATE PURCHASE STATUS TRANSITIONS
-- Update purchases from 'Pending' to 'Paid' or 'Cancelled' to simulate the order lifecycle.
-- Updates to 'Paid' automatically trigger stock deductions through TRIGGER 1.
-- --------------------------------------------------------------------------------------------------

-- Simulate purchases transitioning to 'Paid'
UPDATE purchase
SET purchase_status_id = 1
WHERE purchase_id IN (1, 2, 3, 10, 11, 12, 15, 20, 21, 30, 31, 32, 40, 41, 50, 51, 99, 100);

-- Simulate purchases transitioning to 'Cancelled'
UPDATE purchase
SET purchase_status_id = 3
WHERE purchase_id IN (8, 92);

-- Verify status changes
SELECT purchase_id, purchase_status_id
FROM purchase
WHERE purchase_id IN (1, 2, 3, 8, 10, 11, 12, 15, 20, 21, 30, 31, 32, 40, 41, 50, 51, 92, 99, 100);

-- Verify stock movements generated by TRIGGER 1
SELECT
sm.movement_id,
pi.purchase_id,
sm.purchase_item_id,
sm.quantity,
sm.movement_date
FROM stock_movement sm
INNER JOIN purchase_item pi ON sm.purchase_item_id = pi.purchase_item_id
WHERE pi.purchase_id IN (1, 2, 3, 10, 11, 12, 15, 20, 21, 30, 31, 32, 40, 41, 50, 51, 99, 100);

-- ------------------------------------------------------------------------------------------------------------------
-- 5.3 ETL AND DATA CLEANING
-- Perform a structured ETL process to assess data quality, clean controlled inconsistencies,
-- and validate the integrity of the dataset before analysis.
-- This section includes diagnostic queries, corrective updates, and validation checks applied to the
-- simulated data quality issues intentionally introduced during the data population stage.
-- ------------------------------------------------------------------------------------------------------------------

-- ******************************************************************************************************************
-- 5.3.1. DATA QUALITY ASSESSMENT
-- Detect and diagnose potential data quality issues without modifying the dataset.
-- *******************************************************************************************************************

-- DUPLICATE PURCHASES
-- Identify duplicate purchase groups based on purchase_status_id, payment_method_id, customer_id and purchase_date.
-- Shows combinations occurring more than once.

SELECT
purchase_status_id,
payment_method_id,
customer_id,
purchase_date,
COUNT(*) AS duplicate_count
FROM purchase
GROUP BY
purchase_status_id,
payment_method_id,
customer_id,
purchase_date
HAVING COUNT(*) > 1;

-- Show full purchase records that belong to the duplicate groups found previously.
SELECT
purchase_id,
purchase_status_id,
payment_method_id,
customer_id,
purchase_date
FROM purchase
WHERE(
purchase_status_id,
payment_method_id,
customer_id,
purchase_date
) IN (
SELECT
purchase_status_id,
payment_method_id,
customer_id,
purchase_date
FROM purchase
GROUP BY
purchase_status_id,
payment_method_id,
customer_id,
purchase_date
HAVING COUNT(*) > 1);
-- FINDING: 1 duplicate purchase group involving 2 records (purchase_id 35 and 36).

-- STOCK REPLENISHMENT ANOMALIES
-- Detect potential anomalies in stock replenishments.

-- Unusually low quantities
SELECT
replenishment_id,
product_id,
quantity_replenished
FROM stock_replenishment
WHERE quantity_replenished < 5;
-- FINDING: Replenishment ID 22 replenished just 1 unit of product ID 25.

-- Replenishment before stock alert
SELECT
replenishment_id,
product_id,
stock_alert_date,
replenishment_date
FROM stock_replenishment
WHERE replenishment_date < stock_alert_date;
-- FINDING: Replenishment ID 18 has a replenishment date before the stock alert.

-- Delayed replenishment after stock alert
SELECT
replenishment_id,
product_id,
stock_alert_date,
replenishment_date
FROM stock_replenishment
WHERE DATEDIFF(replenishment_date, stock_alert_date) > 20;
-- FINDING: Replenishment ID 20 was delayed by 3 months after the stock alert.

-- NULL VALUE ANOMALIES
-- Detect potential null values in optional descriptive fields, such as product or category descriptions.

SELECT
product_id,
product_name,
product_description
FROM product
WHERE product_description IS NULL; 
-- FINDING: Products ID 5, 17 and 25 have null descriptions.

SELECT *
FROM product_category
WHERE category_description IS NULL;
-- FINDING: Product Category ID 2 has null description.

-- CUSTOMER CONTACT DATA ANOMALIES
-- Identify potential formatting issues in customer contact information (emails and phone numbers).

SELECT
customer_id,
first_name,
last_name,
email
FROM customer
WHERE email NOT LIKE '%@%.%';
-- FINDING: Customers ID 4, 13 and 31 have invalid email addresses.

SELECT
customer_id,
first_name,
last_name,
phone
FROM customer
WHERE phone NOT REGEXP '^[0-9\- ]+$' OR LENGTH(REPLACE(REPLACE(phone,'-',''),' ','')) < 10;
-- FINDING: Customers ID 5 and 53 have invalid phone numbers.


-- ******************************************************************************************************************
-- 5.3.2. DATA CLEANING
-- Correct identified data quality issues to standardize and prepare the dataset for analysis.
-- *******************************************************************************************************************

-- Remove duplicated purchase identified in the data quality assessment
DELETE
FROM PURCHASE
WHERE purchase_id = 36;

-- Correct replenishment occurring before the stock alert (temporal inconsistency)
UPDATE stock_replenishment
SET replenishment_date = '2025-09-22 00:00:00'
WHERE replenishment_id = 18;

-- Note:
-- Other detected anomalies (e.g., unusually low replenishment quantities or delayed replenishments)
-- were not corrected, as they may represent valid operational events rather than data quality errors.
-- These cases should be reviewed by the relevant operational team.

-- Complete missing values in optional descriptive fields when information is available

-- Product description
UPDATE product
SET product_description = 'Lightweight and breathable sports t-shirt made from eco-friendly materials'
WHERE product_id = 5;

UPDATE product
SET product_description = '100% pure oil for relaxation'
WHERE product_id = 17;

UPDATE product
SET product_description = 'Adjustable dumbbells 2–20 kg'
WHERE product_id = 25;

-- Category description
UPDATE product_category
SET category_description = 'Shoes designed for running, gym workouts, and other fitness activities'
WHERE category_id = 2;

-- Invalid customer contact information formats

-- Note:
-- Some customer email addresses and phone numbers contain invalid formats
-- (e.g., '@email', '@com', or unexpected characters in phone numbers).
-- Since the correct values cannot be reliably inferred, these records were not modified.
-- They should be reviewed and corrected using verified customer information.

-- ******************************************************************************************************************
-- 5.3.3. DATA VALIDATION
-- Verify that the applied data cleaning actions successfully resolved the identified data quality issues.
-- ******************************************************************************************************************

-- Validate that there are no duplicate purchases
SELECT
purchase_status_id,
payment_method_id,
customer_id,
purchase_date,
COUNT(*) AS dupplicate_count
FROM purchase
GROUP BY
purchase_status_id,
payment_method_id,
customer_id,
purchase_date
HAVING COUNT(*) > 1;
-- FINDING: No duplicate purchases found. Validation passed.

-- Validate that stock replenishments occur on or after the stock alert date
SELECT *
FROM stock_replenishment
WHERE replenishment_date < stock_alert_date;
-- FINDING: All stock replenishments have valid dates. Validation passed.

-- Validate that optional descriptive fields are filled when information is available
SELECT * FROM product WHERE product_description IS NULL;
SELECT * FROM product_category WHERE category_description IS NULL;
-- FINDING: All product and category descriptions have been completed. Validation passed.

-- ******************************************************************************************************************
-- 5.4 DATASET READY FOR ANALYSIS
-- After completing data cleaning and validation, the dataset is consistent
-- and ready for analytical queries, business metrics, and reporting.
-- ******************************************************************************************************************

