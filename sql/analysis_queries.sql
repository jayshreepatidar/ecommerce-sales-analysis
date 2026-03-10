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


-- 2. SALES & PRODUCT ANALYSIS

-- Q12. Find top 10 most sold products (based on quantity of order items)
SELECT
product_id,
COUNT(*) AS total_sold
FROM order_items
GROUP BY product_id
ORDER BY total_sold DESC
LIMIT 10;


-- Q13. Find top 10 revenue generating products
SELECT
product_id,
SUM(price) AS total_revenue
FROM order_items
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;


-- Q14. Find total revenue per order
SELECT
order_id,
SUM(price) AS order_revenue
FROM order_items
GROUP BY order_id
ORDER BY order_revenue DESC;


-- Q15. Find average order value
SELECT
ROUND(AVG(order_revenue),2) AS avg_order_value
FROM (
SELECT
order_id,
SUM(price) AS order_revenue
FROM order_items
GROUP BY order_id
) AS order_totals;


-- Q16. Finf average number of items per order
SELECT
ROUND(AVG(item_count),2) AS avg_items_per_order
FROM (
SELECT
order_id,
COUNT(order_item_id) AS item_count
FROM order_items
GROUP BY order_id
) AS order_items_count;


-- Q17. Product categories with most products
SELECT
product_category_name,
COUNT(product_id) AS total_products
FROM products
GROUP BY product_category_name
ORDER BY total_products DESC;


-- Q18. Product categories generating highest revenue
SELECT
p.product_category_name,
SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;


-- Q19. Average price per product category
SELECT
p.product_category_name,
ROUND(AVG(oi.price),2) AS avg_price
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_price DESC;


-- Q20. Top 10 most expensive products
SELECT
product_id,
price
FROM order_items
ORDER BY price DESC
LIMIT 10;


-- Q21. Total freight value paid
SELECT
SUM(freight_value) AS total_freight_value
FROM order_items;


-- Q22. Product category with highest freight value
SELECT
p.product_category_name,
SUM(oi.freight_value) AS total_freight
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_freight DESC;


-- Q23. Products with highest weight
SELECT
product_id,
product_weight_g
FROM products
WHERE product_weight_g IS NOT NULL
ORDER BY product_weight_g DESC
LIMIT 10;


-- Q24. Products with highest number of photos
SELECT
product_id,
product_photos_qty
FROM products
WHERE product_photos_qty IS NOT NULL
ORDER BY product_photos_qty DESC
LIMIT 10;


-- Q25. Average product description length
SELECT
ROUND(AVG(product_description_lenght),2) AS avg_description_length
FROM products;


-- Q26. Orders placed per day
SELECT
DATE(order_purchase_timestamp) AS order_date,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;
