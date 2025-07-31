-- Table
CREATE TABLE students (
  student_id INT,
  name VARCHAR(100),
  grade INT,
  attendance DECIMAL(5,2),
  subject VARCHAR(50),
  email VARCHAR(100)
);

-- Queries
SELECT name, grade FROM students WHERE grade > 80 AND attendance > 90;
SELECT DISTINCT subject FROM students;
SELECT * FROM students WHERE name LIKE 'A%';
SELECT * FROM students WHERE subject IN ('Math', 'Science');
SELECT * FROM students WHERE email IS NULL;
SELECT * FROM students ORDER BY grade DESC, name ASC;
