CREATE DATABASE loan_db;
USE loan_db;

CREATE TABLE loan_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE borrowers (
    borrower_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    borrower_id INT,
    type_id INT,
    amount DECIMAL(10,2),
    disbursement_date DATE,
    FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id),
    FOREIGN KEY (type_id) REFERENCES loan_types(type_id)
);

CREATE TABLE repayments (
    repayment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    amount DECIMAL(10,2),
    due_date DATE,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

-- Sample Queries
-- Total amount repaid per borrower
SELECT b.name, SUM(r.amount) AS total_repaid
FROM repayments r
JOIN loans l ON r.loan_id = l.loan_id
JOIN borrowers b ON l.borrower_id = b.borrower_id
GROUP BY b.name;

-- Upcoming repayment schedule
SELECT * FROM repayments
WHERE due_date > CURDATE()
ORDER BY due_date;
