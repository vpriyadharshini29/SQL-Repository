-- Loan Disbursement and Repayment Tracker

CREATE TABLE loans (loan_id INT PRIMARY KEY, customer_id INT, amount DECIMAL(10,2), status VARCHAR(50));
CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE payments (payment_id INT PRIMARY KEY, loan_id INT, payment_amount DECIMAL(10,2), payment_date DATE);
CREATE TABLE loan_types (loan_type_id INT PRIMARY KEY, name VARCHAR(50));

-- Outstanding balance (SELECT subquery)
SELECT loan_id, amount - (SELECT COALESCE(SUM(payment_amount), 0) FROM payments WHERE payments.loan_id = loans.loan_id) AS balance FROM loans;

-- Repayment per loan type
SELECT lt.name, SUM(p.payment_amount) FROM payments p
JOIN loans l ON p.loan_id = l.loan_id
JOIN loan_types lt ON l.status = lt.name
GROUP BY lt.name;

-- CASE to categorize loan status
SELECT loan_id, status,
CASE
  WHEN status = 'Closed' THEN 'Closed'
  WHEN DATEDIFF(CURDATE(), (SELECT MAX(payment_date) FROM payments WHERE payments.loan_id = loans.loan_id)) > 30 THEN 'Delayed'
  ELSE 'On Track'
END AS category FROM loans;

-- UNION active and closed
SELECT * FROM loans WHERE status = 'Active'
UNION ALL
SELECT * FROM loans WHERE status = 'Closed';

-- Correlated subquery: high payers
SELECT customer_id FROM payments p1 WHERE payment_amount > (
  SELECT AVG(payment_amount) FROM payments p2 WHERE p2.loan_id = p1.loan_id
);

-- DATEDIFF: delay
SELECT loan_id, DATEDIFF(CURDATE(), MAX(payment_date)) AS delay FROM payments GROUP BY loan_id;