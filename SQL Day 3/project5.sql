-- Total deposits and withdrawals per account
SELECT a.account_id, 
       SUM(CASE WHEN t.transaction_type = 'DEPOSIT' THEN t.amount ELSE 0 END) AS total_deposits,
       SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL' THEN t.amount ELSE 0 END) AS total_withdrawals
FROM accounts a
LEFT JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.account_id;

-- Highest and lowest transaction amounts
SELECT MAX(t.amount) AS highest_transaction, MIN(t.amount) AS lowest_transaction
FROM transactions t;

-- Accounts with total withdrawals > ₹10,000
SELECT a.account_id, SUM(t.amount) AS total_withdrawals
FROM accounts a
INNER JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_type = 'WITHDRAWAL'
GROUP BY a.account_id
HAVING SUM(t.amount) > 10000;

-- INNER JOIN customers and accounts
SELECT c.customer_id, c.first_name, a.account_id
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id;

-- LEFT JOIN accounts with no transactions
SELECT a.account_id, t.transaction_id
FROM accounts a
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- SELF JOIN customers from same city
SELECT c1.first_name AS customer1, c2.first_name AS customer2, c1.city
FROM customers c1
INNER JOIN customers c2 ON c1.city = c2.city AND c1.customer_id < c2.customer_id;