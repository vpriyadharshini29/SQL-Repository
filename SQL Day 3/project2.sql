-- Total amount spent per customer
SELECT c.customer_id, c.first_name, SUM(oi.quantity * p.price) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.first_name;

-- Products sold count and total revenue
SELECT p.product_name, COUNT(oi.order_item_id) AS sold_count, SUM(oi.quantity * p.price) AS revenue
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- Group sales by product, filter SUM > 10,000
SELECT p.product_name, SUM(oi.quantity * p.price) AS revenue
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity * p.price) > 10000;

-- INNER JOIN orders, order_items, products
SELECT o.order_id, p.product_name, oi.quantity
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

-- LEFT JOIN customers without orders
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- RIGHT JOIN products never sold
SELECT p.product_name, oi.order_item_id
FROM products p
RIGHT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;