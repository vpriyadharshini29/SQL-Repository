-- Customer Spending Dashboard for an E-commerce Platform

CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT, order_date DATE);
CREATE TABLE order_items (item_id INT PRIMARY KEY, order_id INT, product_id INT, quantity INT, price DECIMAL(10,2));
CREATE TABLE products (product_id INT PRIMARY KEY, name VARCHAR(100), category VARCHAR(50));

-- Average order value per customer (subquery in SELECT)
SELECT customer_id, (SELECT AVG(total) FROM (SELECT SUM(quantity * price) AS total FROM order_items GROUP BY order_id) t) AS avg_order FROM orders;

-- Total revenue per product (subquery in FROM)
SELECT p.name, r.total_revenue FROM products p JOIN (
  SELECT product_id, SUM(quantity * price) AS total_revenue FROM order_items GROUP BY product_id
) r ON p.product_id = r.product_id;

-- Correlated subquery: customers with orders above their own average
SELECT * FROM orders o WHERE (SELECT AVG(quantity * price) FROM order_items WHERE order_id = o.order_id) > (
  SELECT AVG(quantity * price) FROM orders o2 JOIN order_items oi2 ON o2.order_id = oi2.order_id WHERE o2.customer_id = o.customer_id
);

-- UNION of old and new customers
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders WHERE order_date < '2023-01-01')
UNION
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders WHERE order_date >= '2023-01-01');

-- INTERSECT of customers who ordered and reviewed
SELECT customer_id FROM orders
INTERSECT
SELECT customer_id FROM reviews;

-- CASE to categorize customers
SELECT customer_id, SUM(quantity * price) AS total_spent,
CASE
  WHEN SUM(quantity * price) > 10000 THEN 'High Spender'
  WHEN SUM(quantity * price) > 5000 THEN 'Medium'
  ELSE 'Low'
END AS category FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY customer_id;

-- Orders this year
SELECT * FROM orders WHERE YEAR(order_date) = YEAR(CURDATE());