-- Restaurant Order Management

CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE staff (staff_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE menu_items (item_id INT PRIMARY KEY, name VARCHAR(100), price DECIMAL(10,2));
CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT, staff_id INT, item_id INT, order_type VARCHAR(10), FOREIGN KEY(customer_id) REFERENCES customers(customer_id), FOREIGN KEY(staff_id) REFERENCES staff(staff_id), FOREIGN KEY(item_id) REFERENCES menu_items(item_id));

-- Full order info
SELECT o.order_id, c.name, s.name, m.name FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN staff s ON o.staff_id = s.staff_id JOIN menu_items m ON o.item_id = m.item_id;

-- Pizza items
SELECT * FROM menu_items WHERE name LIKE '%Pizza%';

-- Orders per staff
SELECT s.name, COUNT(*) FROM orders o JOIN staff s ON o.staff_id = s.staff_id GROUP BY s.name;

-- Order by amount
SELECT c.name, m.name, m.price FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN menu_items m ON o.item_id = m.item_id ORDER BY m.price DESC, c.name;

-- CASE for customer type
SELECT customer_id, COUNT(*) AS orders,
CASE
  WHEN COUNT(*) > 5 THEN 'Returning'
  ELSE 'New'
END AS customer_type FROM orders GROUP BY customer_id;

-- Subquery for >5 orders
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) > 5);

-- Dine-in and delivery
SELECT * FROM orders WHERE order_type = 'Dine-in'
UNION
SELECT * FROM orders WHERE order_type = 'Delivery';