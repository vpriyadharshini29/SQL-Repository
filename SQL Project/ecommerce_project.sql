
-- DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS shipments, payments, order_details, orders, products, customers;

-- CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- PRODUCTS TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ORDER DETAILS TABLE
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- PAYMENTS TABLE
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE DEFAULT CURRENT_DATE,
    amount DECIMAL(10,2),
    method VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- SHIPMENTS TABLE
CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    shipped_date DATE,
    delivery_date DATE,
    carrier VARCHAR(50),
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- INSERT CUSTOMERS
INSERT INTO customers (name, email, phone, address) VALUES
('Alice Johnson', 'alice@gmail.com', '9876543210', 'Chennai'),
('Bob Smith', 'bob@gmail.com', '9876543211', 'Bangalore'),
('Catherine Lee', 'catherine@gmail.com', '9876543212', 'Mumbai');

-- INSERT PRODUCTS
INSERT INTO products (name, category, price, stock_quantity) VALUES
('Wireless Mouse', 'Electronics', 499.99, 100),
('Bluetooth Headphones', 'Electronics', 1299.00, 80),
('Water Bottle', 'Home & Kitchen', 299.00, 150),
('Notebook', 'Stationery', 99.00, 200),
('Yoga Mat', 'Fitness', 899.00, 50);

-- INSERT ORDERS
INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2025-08-01', 'Delivered'),
(2, '2025-08-02', 'Shipped'),
(3, '2025-08-03', 'Pending'),
(1, '2025-08-05', 'Processing');

-- INSERT ORDER DETAILS
INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 999.98),
(1, 3, 1, 299.00),
(2, 2, 1, 1299.00),
(3, 4, 3, 297.00),
(4, 5, 2, 1798.00);

-- INSERT PAYMENTS
INSERT INTO payments (order_id, payment_date, amount, method, status) VALUES
(1, '2025-08-01', 1298.98, 'Credit Card', 'Paid'),
(2, '2025-08-02', 1299.00, 'UPI', 'Paid'),
(3, '2025-08-03', 297.00, 'Cash on Delivery', 'Pending'),
(4, '2025-08-05', 1798.00, 'Credit Card', 'Paid');

-- INSERT SHIPMENTS
INSERT INTO shipments (order_id, shipped_date, delivery_date, carrier, status) VALUES
(1, '2025-08-01', '2025-08-04', 'BlueDart', 'Delivered'),
(2, '2025-08-02', NULL, 'Delhivery', 'Shipped'),
(4, '2025-08-05', NULL, 'Ecom Express', 'Processing');

-- BI/OLAP QUERIES

-- 1. Monthly Sales Report
SELECT 
    MONTH(order_date) AS month,
    SUM(od.price) AS total_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY MONTH(order_date);

-- 2. Top 3 Selling Products
SELECT 
    p.name, 
    SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 3;

-- 3. Customer Purchase History
SELECT 
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(od.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id;

-- 4. Product Inventory Alert (<50 units)
SELECT name, stock_quantity
FROM products
WHERE stock_quantity < 50;

-- 5. Payment Method Analysis
SELECT method, COUNT(*) AS total_transactions, SUM(amount) AS total_amount
FROM payments
GROUP BY method;

-- 6. Order Status Overview
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;
