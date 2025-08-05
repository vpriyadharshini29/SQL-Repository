-- Warehouse & Supply Chain Inventory System

-- 1. Create Tables
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(100),
    contact_info VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    total_stock INT DEFAULT 0
);

CREATE TABLE batches (
    batch_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    manufactured_date DATE,
    expiry_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    CHECK (expiry_date > manufactured_date)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    supplier_id INT,
    product_id INT,
    quantity INT,
    delivery_date DATE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Insert Deliveries with Supplier Validation
INSERT INTO suppliers (supplier_id, name, contact_info)
VALUES (1, 'MaxSupply Co.', 'contact@maxsupply.com');

INSERT INTO products (product_id, name, total_stock)
VALUES (101, 'Detergent Powder', 0);

INSERT INTO deliveries (delivery_id, supplier_id, product_id, quantity, delivery_date)
VALUES (1, 1, 101, 500, CURRENT_DATE);

-- 3. Update Product Stock Per Delivery
UPDATE products
SET total_stock = total_stock + 500
WHERE product_id = 101;

-- 4. Delete Expired Batches
DELETE FROM batches
WHERE expiry_date < CURRENT_DATE;

-- 5. CHECK (expiry_date > manufactured_date) is already added

-- 6. Drop and Recreate FOREIGN KEY on deliveries
ALTER TABLE deliveries DROP CONSTRAINT deliveries_product_id_fkey;

ALTER TABLE deliveries ADD CONSTRAINT deliveries_product_id_fkey
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE;

-- 7. Use Transaction to Register Delivery and Update Stock in Sync
BEGIN;

-- Insert new delivery
INSERT INTO deliveries (delivery_id, supplier_id, product_id, quantity, delivery_date)
VALUES (2, 1, 101, 300, CURRENT_DATE);

-- Update product stock
UPDATE products
SET total_stock = total_stock + 300
WHERE product_id = 101;

COMMIT;
