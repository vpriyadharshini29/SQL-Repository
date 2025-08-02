-- Online Gadget Store

CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100), location VARCHAR(100));
CREATE TABLE categories (category_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE products (product_id INT PRIMARY KEY, name VARCHAR(100), category_id INT, FOREIGN KEY(category_id) REFERENCES categories(category_id));
CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT, product_id INT, amount DECIMAL(10,2), FOREIGN KEY(customer_id) REFERENCES customers(customer_id), FOREIGN KEY(product_id) REFERENCES products(product_id));

-- Unique customer locations
SELECT DISTINCT location FROM customers;

-- High value orders
SELECT * FROM orders WHERE amount BETWEEN 1000 AND 5000;

-- Customers who never ordered accessories
SELECT * FROM customers WHERE customer_id NOT IN (
  SELECT customer_id FROM orders WHERE product_id IN (SELECT product_id FROM products WHERE category_id = (SELECT category_id FROM categories WHERE name = 'Accessories'))
);

-- MAX and MIN order value
SELECT MAX(amount) AS max_order, MIN(amount) AS min_order FROM orders;

-- Full product category mapping
SELECT p.name, c.name AS category FROM products p JOIN categories c ON p.category_id = c.category_id;

-- Most purchased products
SELECT p.name, COUNT(*) AS purchase_count FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY p.name ORDER BY purchase_count DESC;

-- CASE for VIP customers
SELECT customer_id, SUM(amount) AS total_spent,
CASE
  WHEN SUM(amount) > 10000 THEN 'VIP'
  ELSE 'Regular'
END AS customer_type FROM orders GROUP BY customer_id;