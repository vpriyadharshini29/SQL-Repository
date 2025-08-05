-- Banking Transaction System

-- 1. Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    balance DECIMAL(10, 2) NOT NULL CHECK (balance >= 0),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10, 2),
    type VARCHAR(10), -- 'debit' or 'credit'
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- 2. Insert Account Data
INSERT INTO accounts (account_id, customer_id, balance)
VALUES (1, 101, 10000.00);

-- 3. Update Balance After Transaction (e.g., debit ₹1000)
UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

INSERT INTO transactions (transaction_id, account_id, amount, type, transaction_date)
VALUES (1, 1, 1000, 'debit', CURRENT_DATE);

-- 4. Delete Closed Accounts
DELETE FROM accounts
WHERE balance = 0;

-- 5. Drop FOREIGN KEY to Restructure Relationships
ALTER TABLE transactions DROP CONSTRAINT transactions_account_id_fkey;

-- 6. Transaction: Money Transfer (from A1 to A2)
BEGIN;

-- Debit from A1
UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

INSERT INTO transactions (transaction_id, account_id, amount, type, transaction_date)
VALUES (2, 1, 500, 'debit', CURRENT_DATE);

-- Credit to A2
UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

INSERT INTO transactions (transaction_id, account_id, amount, type, transaction_date)
VALUES (3, 2, 500, 'credit', CURRENT_DATE);

-- If either fails, rollback
-- ROLLBACK;
COMMIT;

-- 7. Isolation Demo: Simulated by running two sessions at once in real DBMS
-- Session 1 starts transfer
BEGIN;
UPDATE accounts SET balance = balance - 1000 WHERE account_id = 1;

-- Session 2 reads balance before Session 1 commits (dirty read if isolation not maintained)
-- SELECT balance FROM accounts WHERE account_id = 1;

-- Back to Session 1
COMMIT;
