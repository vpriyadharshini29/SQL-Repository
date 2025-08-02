-- Sales Performance Analyzer for Retail Chain

CREATE TABLE stores (store_id INT PRIMARY KEY, region VARCHAR(100));
CREATE TABLE products (product_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE employees (emp_id INT PRIMARY KEY, name VARCHAR(100), region VARCHAR(100));
CREATE TABLE sales (sale_id INT PRIMARY KEY, store_id INT, product_id INT, emp_id INT, amount DECIMAL(10,2), sale_date DATE);

-- Store revenue as % of total (subquery in SELECT)
SELECT store_id, SUM(amount) AS revenue,
(SUM(amount) / (SELECT SUM(amount) FROM sales)) * 100 AS percent_total
FROM sales GROUP BY store_id;

-- Top performer in each region
SELECT * FROM employees e WHERE emp_id IN (
  SELECT emp_id FROM sales s WHERE region = e.region GROUP BY emp_id ORDER BY SUM(amount) DESC LIMIT 1
);

-- UNION of online and offline sales
SELECT * FROM online_sales
UNION
SELECT * FROM offline_sales;

-- CASE for product grouping
SELECT product_id, SUM(amount) AS total,
CASE
  WHEN SUM(amount) >= 10000 THEN 'Top Seller'
  WHEN SUM(amount) >= 5000 THEN 'Medium'
  ELSE 'Low'
END AS category FROM sales GROUP BY product_id;

-- Monthly sales trends
SELECT MONTH(sale_date) AS month, YEAR(sale_date) AS year, SUM(amount) AS total FROM sales GROUP BY MONTH(sale_date), YEAR(sale_date);

-- Store-level performance
SELECT s.store_id, SUM(amount) FROM sales s JOIN stores st ON s.store_id = st.store_id GROUP BY s.store_id;