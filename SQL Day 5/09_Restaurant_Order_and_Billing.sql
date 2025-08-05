-- Restaurant Order and Billing System

-- 1. Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    price DECIMAL(10, 2),
    availability BOOLEAN
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    item_id INT,
    quantity INT CHECK (quantity <= 10),
    order_time TIMESTAMP,
    table_number INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

CREATE TABLE bills (
    bill_id INT PRIMARY KEY,
    order_id INT,
    total_amount DECIMAL(10, 2),
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 2. Insert an Order
INSERT INTO orders (order_id, customer_id, item_id, quantity, order_time, table_number)
VALUES (1, 101, 201, 2, CURRENT_TIMESTAMP, 3);

-- 3. Update Item Availability After Order
UPDATE menu_items
SET availability = FALSE
WHERE item_id = 201;

-- 4. Delete Unpaid Orders After 30 Minutes
DELETE FROM orders
WHERE order_time < NOW() - INTERVAL '30 minutes'
  AND order_id NOT IN (
    SELECT order_id FROM bills WHERE payment_status = 'Paid'
);

-- 5. Drop and Reapply NOT NULL Constraint on table_number
-- Drop NOT NULL
ALTER TABLE orders ALTER COLUMN table_number DROP NOT NULL;

-- Reapply NOT NULL
ALTER TABLE orders ALTER COLUMN table_number SET NOT NULL;

-- 6. Transaction: Create Order and Bill Together
BEGIN;

-- Insert Order
INSERT INTO orders (order_id, customer_id, item_id, quantity, order_time, table_number)
VALUES (2, 102, 202, 1, CURRENT_TIMESTAMP, 5);

-- Insert Bill
INSERT INTO bills (bill_id, order_id, total_amount, payment_status)
VALUES (1, 2, 299.00, 'Pending');

-- ROLLBACK; -- Uncomment if any error occurs
COMMIT;
