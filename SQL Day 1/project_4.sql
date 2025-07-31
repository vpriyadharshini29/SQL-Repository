-- Create database
CREATE DATABASE IF NOT EXISTS company_hr;
USE company_hr;

-- Departments table
CREATE TABLE departments (
  dept_id INT PRIMARY KEY AUTO_INCREMENT,
  dept_name VARCHAR(100) UNIQUE NOT NULL
);

-- Employees table
CREATE TABLE employees (
  emp_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Attendance table
CREATE TABLE attendance (
  attendance_id INT PRIMARY KEY AUTO_INCREMENT,
  emp_id INT,
  date DATE,
  in_time TIME,
  out_time TIME,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Insert departments
INSERT INTO departments (dept_name) VALUES
('HR'), ('Finance'), ('Engineering'), ('Marketing'), ('Sales');

-- Insert employees
INSERT INTO employees (name, dept_id) VALUES
('Alice', 1), ('Bob', 2), ('Charlie', 3), ('Diana', 3), ('Eve', 4),
('Frank', 5), ('Grace', 1), ('Heidi', 2), ('Ivan', 4), ('Judy', 5),
('Ken', 3), ('Leo', 2), ('Mona', 4), ('Nina', 5), ('Oscar', 1);

-- Insert attendance (30 entries)
INSERT INTO attendance (emp_id, date, in_time, out_time) VALUES
(1,'2025-07-01','09:00','17:00'), (2,'2025-07-01','09:15','17:10'),
(3,'2025-07-01','09:00','18:00'), (4,'2025-07-01','09:30','17:30'),
(5,'2025-07-01','09:00','17:00'), (1,'2025-07-02','09:10','17:20'),
(2,'2025-07-02','09:00','17:00'), (3,'2025-07-02','09:15','18:00'),
(4,'2025-07-02','09:10','17:30'), (5,'2025-07-02','09:00','17:15'),
(6,'2025-07-01','09:00','16:45'), (7,'2025-07-01','09:20','17:10'),
(8,'2025-07-01','09:00','17:00'), (9,'2025-07-01','09:30','18:00'),
(10,'2025-07-01','09:00','17:00'), (11,'2025-07-01','09:15','17:30'),
(12,'2025-07-01','09:00','16:50'), (13,'2025-07-01','09:00','17:00'),
(14,'2025-07-01','09:05','17:00'), (15,'2025-07-01','09:00','17:15'),
(6,'2025-07-02','09:00','16:45'), (7,'2025-07-02','09:20','17:10'),
(8,'2025-07-02','09:00','17:00'), (9,'2025-07-02','09:30','18:00'),
(10,'2025-07-02','09:00','17:00'), (11,'2025-07-02','09:15','17:30'),
(12,'2025-07-02','09:00','16:50'), (13,'2025-07-02','09:00','17:00'),
(14,'2025-07-02','09:05','17:00'), (15,'2025-07-02','09:00','17:15');

-- SELECT: Calculate working hours
SELECT e.name, a.date, TIMEDIFF(a.out_time, a.in_time) AS working_hours
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id;

-- SELECT: Count present days
SELECT e.name, COUNT(a.attendance_id) AS present_days
FROM employees e
LEFT JOIN attendance a ON e.emp_id = a.emp_id
GROUP BY e.emp_id;
