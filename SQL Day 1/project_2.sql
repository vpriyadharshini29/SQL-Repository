-- 1. Create the database
DROP DATABASE IF EXISTS grocery_store;
CREATE DATABASE grocery_store;
USE grocery_store;

-- 2. Create the categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- 3. Create the suppliers table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL UNIQUE,
    contact_email VARCHAR(100) DEFAULT 'not_provided@example.com'
);

-- 4. Create the products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    discontinued BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- 5. Insert sample categories
INSERT INTO categories (category_name) VALUES 
('Fruits'),
('Vegetables'),
('Dairy'),
('Bakery'),
('Beverages');

-- 6. Insert sample suppliers
INSERT INTO suppliers (supplier_name, contact_email) VALUES 
('Fresh Farms Ltd', 'fresh@farms.com'),
('GreenLeaf Suppliers', 'greenleaf@suppliers.com'),
('DairyWorld Inc.', 'support@dairyworld.com'),
('BakeHouse Co.', 'sales@bakehouse.com'),
('Thirst Quenchers', 'contact@quenchers.com');

-- 7. Insert 20 products across the 5 categories
INSERT INTO products (product_name, price, stock, category_id, supplier_id) VALUES
('Apple', 2.50, 100, 1, 1),
('Banana', 1.20, 120, 1, 1),
('Orange', 2.00, 80, 1, 1),
('Spinach', 1.80, 60, 2, 2),
('Carrot', 1.50, 90, 2, 2),
('Potato', 0.90, 150, 2, 2),
('Milk', 3.00, 50, 3, 3),
('Cheese', 5.00, 40, 3, 3),
('Yogurt', 2.20, 70, 3, 3),
('Bread', 2.80, 60, 4, 4),
('Croissant', 3.50, 30, 4, 4),
('Muffin', 2.00, 35, 4, 4),
('Water Bottle', 1.00, 200, 5, 5),
('Orange Juice', 3.00, 75, 5, 5),
('Soda Can', 1.50, 100, 5, 5),
('Tomato', 1.70, 80, 2, 2),
('Lettuce', 1.60, 60, 2, 2),
('Butter', 4.00, 45, 3, 3),
('Bagel', 2.30, 40, 4, 4),
('Grapes', 2.80, 85, 1, 1);

-- 8. Update stock level of a product
UPDATE products
SET stock = stock + 25
WHERE product_name = 'Milk';

-- 9. Delete discontinued products
DELETE FROM products
WHERE discontinued = TRUE;

-- 10. Group products by category and count them
SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;
