-- Table
CREATE TABLE sales (
  sale_id INT,
  item_name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2),
  quantity INT,
  sale_date DATE
);

-- Queries
SELECT * FROM sales WHERE price > 500 AND quantity >= 2;
SELECT * FROM sales WHERE item_name LIKE '%Pro%';
SELECT * FROM sales WHERE quantity IS NULL;
SELECT DISTINCT category FROM sales;
SELECT * FROM sales ORDER BY sale_date DESC, price DESC;
