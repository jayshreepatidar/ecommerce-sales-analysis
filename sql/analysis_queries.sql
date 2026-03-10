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


-- 3. CUSTOMER & BUSINESS INSIGHTS

-- Q27. Top 10 customers with highest number of orders
SELECT
c.customer_id,
COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 10;


-- Q28. Top 10 customers by total spending
SELECT
c.customer_id,
SUM(oi.price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- Q29. Find Customers who placed only one order.
SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1;


-- Q30. Find Cities generating highest revenue
SELECT
c.customer_city,
SUM(oi.price) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;


-- Q31. States generating highest revenue
SELECT
c.customer_state,
SUM(oi.price) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;


-- Q32. Monthly sales trend
SELECT
DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
SUM(oi.price) AS monthly_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;


-- Q33. Monthly order growth
SELECT
DATE_TRUNC('month', order_purchase_timestamp) AS month,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;


-- Q34. On average, how many days it takes for an order to be delivered after it is purchased.
SELECT
AVG(order_delivered_customer_date - order_purchase_timestamp) AS avg_delivery_time
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- Q35. Orders delivered later than estimated date.
SELECT
COUNT(*) AS late_deliveries
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;


-- Q36. Find the distribution of payments by payment type.
SELECT
payment_type,
COUNT(*) AS total_payments
FROM order_payments
GROUP BY payment_type
ORDER BY total_payments DESC;


-- 4. ADVANCED SQL (WINDOW FUNCTIONS)

-- Q37. Rank products based on total revenue generated
SELECT
product_id,
SUM(price) AS total_revenue,
RANK() OVER (ORDER BY SUM(price) DESC) AS revenue_rank
FROM order_items
GROUP BY product_id;

-- Q38. Rank customers based on total spending
SELECT
c.customer_id,
SUM(oi.price) AS total_spent,
RANK() OVER (ORDER BY SUM(oi.price) DESC) AS customer_rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id;


-- Q39. Calculate daily revenue and the cumulative running total of revenue over time.
SELECT
DATE(o.order_purchase_timestamp) AS order_date,
SUM(oi.price) AS daily_revenue,
SUM(SUM(oi.price)) OVER (ORDER BY DATE(o.order_purchase_timestamp)) AS running_total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY order_date
ORDER BY order_date;
