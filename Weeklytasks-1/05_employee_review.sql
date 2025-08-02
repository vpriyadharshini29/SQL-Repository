-- Employee Performance Review System

CREATE TABLE employees (emp_id INT PRIMARY KEY, name VARCHAR(100), manager_id INT, dept_id INT);
CREATE TABLE departments (dept_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE reviews (review_id INT PRIMARY KEY, emp_id INT, review_date DATE, score INT, FOREIGN KEY(emp_id) REFERENCES employees(emp_id));

-- SELF JOIN
SELECT e.name AS employee, m.name AS manager FROM employees e LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- ROW_NUMBER (optional)
SELECT emp_id, review_date, score, ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY review_date DESC) AS review_rank FROM reviews;

-- Avg score per department
SELECT d.name, AVG(r.score) FROM reviews r JOIN employees e ON r.emp_id = e.emp_id JOIN departments d ON e.dept_id = d.dept_id GROUP BY d.name;

-- CASE for ratings
SELECT score, CASE
  WHEN score >= 90 THEN 'Excellent'
  WHEN score >= 70 THEN 'Good'
  ELSE 'Average'
END AS rating FROM reviews;

-- Filter completed reviews
SELECT * FROM reviews WHERE score IS NOT NULL;

-- Subquery to fetch latest review
SELECT emp_id, (SELECT MAX(review_date) FROM reviews r2 WHERE r2.emp_id = r1.emp_id) AS latest_review FROM reviews r1;

-- Sort by score and department
SELECT e.name, d.name AS department, r.score FROM reviews r JOIN employees e ON r.emp_id = e.emp_id JOIN departments d ON e.dept_id = d.dept_id ORDER BY r.score DESC, d.name;