-- Employee Payroll System

-- 1. Create Tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE salaries (
    salary_id INT PRIMARY KEY,
    employee_id INT UNIQUE,
    amount DECIMAL(10, 2) CHECK (amount > 10000),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 2. Insert Employees
INSERT INTO departments VALUES (1, 'HR'), (2, 'Engineering');

INSERT INTO employees (employee_id, name, email, dept_id) 
VALUES 
(101, 'Alice', 'alice@example.com', 1),
(102, 'Bob', 'bob@example.com', 2);

-- 3. Insert Salaries
INSERT INTO salaries (salary_id, employee_id, amount)
VALUES 
(1, 101, 15000),
(2, 102, 18000);

-- 4. Update Salary for Promotion
UPDATE salaries SET amount = amount + 5000 WHERE employee_id = 101;

-- 5. Delete Resigned Employee
DELETE FROM employees WHERE employee_id = 102;

-- 6. Modify Constraint on Email Length
ALTER TABLE employees ADD CONSTRAINT email_length CHECK (LENGTH(email) <= 100);

-- Drop it
ALTER TABLE employees DROP CONSTRAINT email_length;

-- 7. Transaction: Bulk Bonus Insertion
BEGIN;

SAVEPOINT before_bonus;

INSERT INTO salaries (salary_id, employee_id, amount)
VALUES 
(3, 103, 20000); -- Assume 103 does not exist → FK violation

-- If error:
ROLLBACK TO before_bonus;

-- Otherwise:
-- COMMIT;
