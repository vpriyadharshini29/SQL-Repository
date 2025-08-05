-- Library Management System

-- 1. Create Tables
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    stock INT
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 2. Insert Books
INSERT INTO books (book_id, title, isbn, stock) 
VALUES (1, 'Database Systems', '978-1234567890', 5);

-- 3. Update Book Stock after Loan
UPDATE books
SET stock = stock - 1
WHERE book_id = 1;

-- 4. Delete Loans after Return
DELETE FROM loans
WHERE loan_id = 101;

-- 5. CHECK: Max 3 Active Loans per Member
ALTER TABLE loans
ADD CONSTRAINT max_3_loans_per_member CHECK (
    (SELECT COUNT(*) FROM loans l WHERE l.member_id = loans.member_id AND l.return_date IS NULL) <= 3
);

-- (⚠️ Note: Some SQL engines don't allow subqueries in CHECK constraints. Use triggers instead if needed.)

-- 6. Temporarily Disable and Re-enable CHECK (Simulation using constraint DROP/ADD)
ALTER TABLE loans DROP CONSTRAINT max_3_loans_per_member;

-- Perform bulk updates, then re-add:
ALTER TABLE loans
ADD CONSTRAINT max_3_loans_per_member CHECK (
    (SELECT COUNT(*) FROM loans l WHERE l.member_id = loans.member_id AND l.return_date IS NULL) <= 3
);

-- 7. Transactions: Rollback if Stock Exceeded
BEGIN;

-- Simulate stock check
UPDATE books
SET stock = stock - 1
WHERE book_id = 1;

-- If stock < 0 → error condition
-- Simulate failure
-- ROLLBACK;

-- If all is good:
COMMIT;
