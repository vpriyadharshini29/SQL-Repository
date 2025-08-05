-- Subscription Billing and Plan Management

-- 1. Create Tables
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE plans (
    plan_id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    CHECK (start_date < end_date)
);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    plan_id INT,
    renewal_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    subscription_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);

-- 2. Insert Subscription Records with FOREIGN KEY to Plans
INSERT INTO subscriptions (subscription_id, user_id, plan_id, renewal_date)
VALUES (1, 101, 201, '2025-09-01');

-- 3. Update Renewal Dates
UPDATE subscriptions
SET renewal_date = renewal_date + INTERVAL '1 month'
WHERE subscription_id = 1;

-- 4. Delete Expired Plans
DELETE FROM plans
WHERE end_date < CURRENT_DATE;

-- 5. CHECK (start_date < end_date) is already defined in table creation

-- 6. Use SAVEPOINT Before Renewal Updates
BEGIN;

SAVEPOINT before_renewal;

-- Simulate a mistake
UPDATE subscriptions
SET renewal_date = '2020-01-01'
WHERE subscription_id = 1;

-- Suppose we realize this is invalid
ROLLBACK TO SAVEPOINT before_renewal;

-- Correct update
UPDATE subscriptions
SET renewal_date = CURRENT_DATE + INTERVAL '1 month'
WHERE subscription_id = 1;

COMMIT;

-- 7. Ensure Durability by committing before disconnect/crash
-- COMMIT ensures changes remain even if connection is lost.
