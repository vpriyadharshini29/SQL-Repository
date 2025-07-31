-- Average salary per department
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Count employees per department
SELECT d.department_name, COUNT(e.employee_id) AS emp_count
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Departments with more than 5 employees
SELECT d.department_name, COUNT(e.employee_id) AS emp_count
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 5;

-- INNER JOIN employees and department names
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- LEFT JOIN to find departments without employees
SELECT d.department_name, e.employee_id
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- SELF JOIN to show employee and manager
SELECT e1.first_name AS employee, e2.first_name AS manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;