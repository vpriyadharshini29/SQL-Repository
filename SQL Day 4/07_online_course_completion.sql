-- Online Course Completion Analytics

CREATE TABLE courses (course_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE students (student_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE enrollments (enroll_id INT PRIMARY KEY, student_id INT, course_id INT);
CREATE TABLE completion (id INT PRIMARY KEY, student_id INT, course_id INT, score INT, completion_date DATE);

-- Completion rate per course
SELECT course_id, (COUNT(*) / (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id)) AS rate
FROM completion c GROUP BY course_id;

-- INTERSECT SQL and Python
SELECT student_id FROM completion WHERE course_id = (SELECT course_id FROM courses WHERE name = 'SQL')
INTERSECT
SELECT student_id FROM completion WHERE course_id = (SELECT course_id FROM courses WHERE name = 'Python');

-- UNION two batches
SELECT * FROM students WHERE batch = '2024'
UNION
SELECT * FROM students WHERE batch = '2025';

-- CASE grading
SELECT score,
CASE
  WHEN score >= 90 THEN 'A'
  WHEN score >= 75 THEN 'B'
  WHEN score >= 60 THEN 'C'
  ELSE 'F'
END AS grade FROM completion;

-- Highest scorer per course
SELECT * FROM completion c1 WHERE score = (
  SELECT MAX(score) FROM completion c2 WHERE c2.course_id = c1.course_id
);

-- Completion trend by month
SELECT MONTH(completion_date) AS month, COUNT(*) FROM completion GROUP BY MONTH(completion_date);