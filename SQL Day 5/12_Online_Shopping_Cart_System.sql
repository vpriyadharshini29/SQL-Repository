-- Online Shopping Cart System

-- 1. Create Tables
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE cart_items (
    cart_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT CHECK (quantity BETWEEN 1 AND 10),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 2. Insert Products into Cart With Foreign Key to Product
INSERT INTO cart_items (cart_id, user_id, product_id, quantity)
VALUES (1, 101, 201, 2);

-- 3. Update Item Quantities and Total Price
UPDATE cart_items
SET quantity = 3
WHERE cart_id = 1;

-- Assume a stored procedure or calculation updates total in orders

-- 4. Delete Abandoned Carts After 7 Days
DELETE FROM cart_items
WHERE user_id IN (
    SELECT user_id
    FROM users
    WHERE user_id NOT IN (
        SELECT user_id FROM orders WHERE order_date >= CURRENT_DATE - INTERVAL '7 days'
    )
);

-- 5. Drop and Re-add Constraint on Cart Uniqueness
-- Assume uniqueness is on user_id + product_id combination
ALTER TABLE cart_items DROP CONSTRAINT IF EXISTS unique_cart;
ALTER TABLE cart_items ADD CONSTRAINT unique_cart UNIQUE (user_id, product_id);

-- 6. Use Transaction to Place Order, Update Stock, and Clear Cart
BEGIN;

-- Create Order
INSERT INTO orders (order_id, user_id, order_date, total_amount)
VALUES (1, 101, CURRENT_DATE, 1500.00);

-- Update stock
UPDATE products
SET stock = stock - (
    SELECT quantity FROM cart_items WHERE cart_id = 1
)
WHERE product_id = (
    SELECT product_id FROM cart_items WHERE cart_id = 1
);

-- Clear Cart
DELETE FROM cart_items WHERE user_id = 101;

COMMIT;
