-- Bank Transactions and Customer Profiles

CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE accounts (account_id INT PRIMARY KEY, customer_id INT, type VARCHAR(20), balance DECIMAL(10,2), FOREIGN KEY(customer_id) REFERENCES customers(customer_id));
CREATE TABLE transactions (trans_id INT PRIMARY KEY, account_id INT, amount DECIMAL(10,2), trans_date DATE, FOREIGN KEY(account_id) REFERENCES accounts(account_id));

-- Accounts with no transactions
SELECT * FROM accounts WHERE account_id NOT IN (SELECT DISTINCT account_id FROM transactions);

-- Join account + customer
SELECT c.name, a.type, a.balance FROM accounts a JOIN customers c ON a.customer_id = c.customer_id;

-- Total deposits per customer
SELECT c.name, SUM(t.amount) AS total_deposits FROM transactions t JOIN accounts a ON t.account_id = a.account_id JOIN customers c ON a.customer_id = c.customer_id WHERE t.amount > 0 GROUP BY c.name;

-- CASE for risk
SELECT account_id, balance,
CASE
  WHEN balance < 1000 THEN 'High Risk'
  WHEN balance < 5000 THEN 'Medium Risk'
  ELSE 'Low Risk'
END AS risk_level FROM accounts;

-- Daily balance change
SELECT trans_date, SUM(amount) AS daily_change FROM transactions GROUP BY trans_date;

-- UNION ALL savings + current accounts
SELECT * FROM accounts WHERE type = 'Savings'
UNION ALL
SELECT * FROM accounts WHERE type = 'Current';