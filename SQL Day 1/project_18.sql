CREATE DATABASE bank_db;
USE bank_db;

CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    branch_id INT,
    balance DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    amount DECIMAL(10,2),
    type ENUM('credit', 'debit'),
    trans_date DATETIME,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Sample Queries
-- Show transaction history
SELECT * FROM transactions
WHERE account_id = 1
ORDER BY trans_date DESC;

-- Calculate account balances (net total)
SELECT account_id,
    SUM(CASE WHEN type = 'credit' THEN amount ELSE -amount END) AS net_balance
FROM transactions
GROUP BY account_id;

