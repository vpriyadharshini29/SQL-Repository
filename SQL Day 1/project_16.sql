CREATE DATABASE medical_store_db;
USE medical_store_db;

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE medicines (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    supplier_id INT,
    batch_no VARCHAR(50),
    expiry_date DATE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE stock (
    stock_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT,
    quantity INT,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT,
    quantity_sold INT,
    sale_date DATE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- Sample Queries
-- Find low stock items
SELECT m.name, s.quantity
FROM stock s
JOIN medicines m ON s.medicine_id = m.medicine_id
WHERE s.quantity < 10;

-- Sales by medicine and supplier
SELECT m.name AS medicine, sup.name AS supplier, SUM(s.quantity_sold) AS total_sold
FROM sales s
JOIN medicines m ON s.medicine_id = m.medicine_id
JOIN suppliers sup ON m.supplier_id = sup.supplier_id
GROUP BY m.medicine_id, sup.supplier_id;
