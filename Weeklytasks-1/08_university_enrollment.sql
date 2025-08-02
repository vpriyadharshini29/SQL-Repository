-- University Course Enrollment Dashboard

CREATE TABLE departments (dept_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE students (student_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE courses (course_id INT PRIMARY KEY, name VARCHAR(100), dept_id INT, FOREIGN KEY(dept_id) REFERENCES departments(dept_id));
CREATE TABLE enrollments (enroll_id INT PRIMARY KEY, student_id INT, course_id INT, grade INT, FOREIGN KEY(student_id) REFERENCES students(student_id), FOREIGN KEY(course_id) REFERENCES courses(course_id));

-- Enrollment count per course
SELECT c.name, COUNT(*) AS enrolled FROM enrollments e JOIN courses c ON e.course_id = c.course_id GROUP BY c.name;

-- Courses with highest dropout (subquery)
SELECT * FROM (
  SELECT course_id, COUNT(*) AS drops FROM enrollments WHERE grade IS NULL GROUP BY course_id
) sub WHERE drops = (SELECT MAX(drops) FROM (SELECT COUNT(*) AS drops FROM enrollments WHERE grade IS NULL GROUP BY course_id) sub2);

-- Students not enrolled in any course
SELECT * FROM students WHERE student_id NOT IN (SELECT student_id FROM enrollments);

-- CASE for pass/fail
SELECT enroll_id, grade,
CASE
  WHEN grade >= 50 THEN 'Pass'
  ELSE 'Fail'
END AS result FROM enrollments;

-- IN filter for list of course codes
SELECT * FROM courses WHERE course_id IN (101, 102, 103);

-- INTERSECT: completed both Python and SQL
SELECT student_id FROM enrollments WHERE course_id = (SELECT course_id FROM courses WHERE name = 'Python') AND grade >= 50
INTERSECT
SELECT student_id FROM enrollments WHERE course_id = (SELECT course_id FROM courses WHERE name = 'SQL') AND grade >= 50;