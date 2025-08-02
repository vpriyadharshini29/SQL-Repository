-- Digital Wallet Transactions Monitor

CREATE TABLE users (user_id INT PRIMARY KEY, name VARCHAR(100), city VARCHAR(100));
CREATE TABLE transactions (txn_id INT PRIMARY KEY, user_id INT, amount DECIMAL(10,2), txn_type VARCHAR(50), txn_date DATE);
CREATE TABLE accounts (acc_id INT PRIMARY KEY, user_id INT);

-- Avg txn value per user
SELECT user_id, AVG(amount) FROM transactions GROUP BY user_id;

-- Total by city
SELECT u.city, SUM(t.amount) FROM users u JOIN transactions t ON u.user_id = t.user_id GROUP BY u.city;

-- CASE txn types
SELECT txn_id, txn_type,
CASE
  WHEN txn_type = 'CR' THEN 'Credit'
  WHEN txn_type = 'DB' THEN 'Debit'
  ELSE 'Refund'
END AS txn_label FROM transactions;

-- UNION wallet systems
SELECT * FROM wallet1.transactions
UNION
SELECT * FROM wallet2.transactions;

-- INTERSECT users in both
SELECT user_id FROM wallet1.users
INTERSECT
SELECT user_id FROM wallet2.users;

-- Filter by week/month
SELECT * FROM transactions WHERE txn_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);