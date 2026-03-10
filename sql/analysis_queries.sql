-- Project: E-commerce Sales Analysis
-- Author: Jayshree Patidar
-- Database: PostgreSQL
-- Description: Basic Data Exploration Queries


-- 1. BASIC DATA EXPLORATION

-- Q1. Find Total Number of Customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;


-- Q2. Find Total Number of Orders
SELECT COUNT(order_id) AS total_orders
FROM orders;


-- Q3. Find Total Number of Products
SELECT COUNT(product_id) AS total_products
FROM products;


-- Q4. Find Total Number of Order Items
SELECT COUNT(*) AS total_order_items
FROM order_items;


-- Q5. Calculate Total Revenue Generated
SELECT SUM(payment_value) AS total_revenue
FROM order_payments;


-- Q6. Count Orders by Status
SELECT order_status,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Q7. Find Top 10 Cities with Most Customers
SELECT customer_city,
       COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;


-- Q8. Find Top 10 States with Most Customers
SELECT customer_state,
       COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;


-- Q9. Find Minimum and Maximum Product Price
SELECT MIN(price) AS minimum_price,
       MAX(price) AS maximum_price
FROM order_items;


-- Q10. Find Average Product Price
SELECT ROUND(AVG(price),2) AS average_product_price
FROM order_items;


-- Q11 Finds the first and last order date
SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM orders;
