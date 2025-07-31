-- Table
CREATE TABLE orders (
  order_id INT,
  customer_name VARCHAR(100),
  total DECIMAL(10,2),
  order_date DATE,
  status VARCHAR(20),
  address TEXT
);

-- Queries
SELECT * FROM orders WHERE order_date >= CURRENT_DATE - INTERVAL 7 DAY;
SELECT * FROM orders WHERE customer_name LIKE 'R%';
SELECT * FROM orders WHERE status IS NULL;
SELECT DISTINCT address FROM orders;
SELECT * FROM orders ORDER BY order_date DESC, total DESC;
