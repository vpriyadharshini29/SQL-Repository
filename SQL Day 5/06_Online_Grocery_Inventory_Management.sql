-- Online Grocery Inventory Management

-- 1. Create Tables
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_code VARCHAR(50) UNIQUE,
    category_id INT,
    supplier_id INT,
    price DECIMAL(10, 2),
    quantity INT CHECK (quantity >= 0),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE stock_logs (
    log_id INT PRIMARY KEY,
    product_id INT,
    change_qty INT,
    change_reason VARCHAR(100),
    log_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Insert Product
INSERT INTO products (product_id, product_name, product_code, category_id, supplier_id, price, quantity)
VALUES (1, 'Organic Rice', 'PR001', 10, 100, 55.50, 500);

-- 3. Update Price and Quantity
UPDATE products
SET price = 58.00, quantity = quantity + 100
WHERE product_id = 1;

-- 4. Delete Expired Products (simulate with dummy condition)
DELETE FROM products
WHERE product_name LIKE '%Expired%';

-- 5. Drop and Recreate UNIQUE on product_code
ALTER TABLE products DROP CONSTRAINT products_product_code_key; -- Replace with actual constraint name if needed

ALTER TABLE products
ADD CONSTRAINT unique_product_code UNIQUE (product_code);

-- 6. Transaction with SAVEPOINT for Bulk Price Update
BEGIN;

SAVEPOINT before_update;

UPDATE products
SET price = price * 1.05;

-- Simulate a failure
-- ROLLBACK TO SAVEPOINT before_update;

-- If everything succeeds
COMMIT;

-- 7. Atomic Update: Inventory and Stock Log
BEGIN;

UPDATE products
SET quantity = quantity - 50
WHERE product_id = 1;

INSERT INTO stock_logs (log_id, product_id, change_qty, change_reason, log_date)
VALUES (1, 1, -50, 'Sold 50 units', CURRENT_DATE);

-- COMMIT or ROLLBACK
COMMIT;
