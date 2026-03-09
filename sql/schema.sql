-- E-Commerce Sales Analysis Database Schema
-- Author: Jayshree Patidar
-- Description: Schema creation, data validation, and constraints for the e-commerce dataset



-- 1. CREATE TABLES


-- Customers table: Stores customer information
CREATE TABLE customers (
customer_id TEXT,
customer_unique_id TEXT,
customer_zip_code_prefix INT,
customer_city TEXT,
customer_state TEXT
);


-- Orders table: Stores order level information
CREATE TABLE orders (
order_id TEXT,
customer_id TEXT,
order_status VARCHAR(20),
order_purchase_timestamp TIMESTAMP,
order_approved_at TIMESTAMP,
order_delivered_carrier_date TIMESTAMP,
order_delivered_customer_date TIMESTAMP,
order_estimated_delivery_date TIMESTAMP
);


-- Order Items table: Each row represents an item in an order
CREATE TABLE order_items (
order_id TEXT,
order_item_id INT,
product_id TEXT,
seller_id TEXT,
shipping_limit_date TIMESTAMP,
price NUMERIC,
freight_value NUMERIC
);


-- Products table: Contains product details
CREATE TABLE products (
product_id TEXT,
product_category_name TEXT,
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g INT,
product_lenght_cm INT,
product_height_cm INT,
product_width_cm INT
);


-- Order Payments table: Stores payment details for each order
CREATE TABLE order_payments (
order_id TEXT,
payment_sequential INT,
payment_type TEXT,
payment_installments INT,
payment_value NUMERIC
);


-- 2. VERIFY TABLE CREATION

-- Check all tables created in public schema
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

 
-- 3. VERIFY DATA IMPORT

-- Check number of records in each table

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM products;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM order_items;

SELECT COUNT(*) FROM order_payments;

-- Preview customer data
SELECT *
FROM customers
LIMIT 10;


-- 4. DATA QUALITY CHECKS

-- Check NULL values in Customers
SELECT *
FROM customers
WHERE customer_id IS NULL
OR customer_unique_id IS NULL
OR customer_zip_code_prefix IS NULL
OR customer_city IS NULL
OR customer_state IS NULL;

-- Check duplicate customer IDs
SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check NULL values in Orders
SELECT *
FROM orders
WHERE order_id IS NULL
OR customer_id IS NULL;

-- Check duplicate order IDs
SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check NULL values in Order Items
SELECT *
FROM order_items
WHERE order_id IS NULL
OR order_item_id IS NULL
OR product_id IS NULL;

-- Check duplicate composite key
SELECT order_id, order_item_id, COUNT(*)
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- Check NULL values in Products
SELECT *
FROM products
WHERE product_id IS NULL;

-- Check duplicate product IDs
SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check NULL values in Order Payments
SELECT *
FROM order_payments
WHERE order_id IS NULL
OR payment_sequential IS NULL;

-- Check duplicate payment entries
SELECT order_id, payment_sequential, COUNT(*)
FROM order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;


-- 5. ADD PRIMARY KEYS

-- Customers primary key
ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

-- Orders primary key
ALTER TABLE orders
ADD PRIMARY KEY (order_id);

-- Products primary key
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Order Items composite primary key
ALTER TABLE order_items
ADD PRIMARY KEY (order_id, order_item_id);

-- Order Payments composite primary key
ALTER TABLE order_payments
ADD PRIMARY KEY (order_id, payment_sequential);


-- 6. ADD FOREIGN KEY RELATIONSHIPS

-- Orders linked to Customers
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- Order Items linked to Orders
ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- Order Items linked to Products
ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- Order Payments linked to Orders
ALTER TABLE order_payments
ADD CONSTRAINT fk_payments_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);


