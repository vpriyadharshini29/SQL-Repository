-- Online Course Platform

CREATE TABLE students (student_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE courses (course_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE enrollments (enroll_id INT PRIMARY KEY, student_id INT, course_id INT, FOREIGN KEY(student_id) REFERENCES students(student_id), FOREIGN KEY(course_id) REFERENCES courses(course_id));
CREATE TABLE grades (grade_id INT PRIMARY KEY, enroll_id INT, score INT, FOREIGN KEY(enroll_id) REFERENCES enrollments(enroll_id));

-- Students in course
SELECT s.name FROM students s JOIN enrollments e ON s.student_id = e.student_id JOIN courses c ON e.course_id = c.course_id WHERE c.name = 'Python';

-- INNER JOIN with scores
SELECT s.name, c.name, g.score FROM students s JOIN enrollments e ON s.student_id = e.student_id JOIN courses c ON e.course_id = c.course_id JOIN grades g ON e.enroll_id = g.enroll_id;

-- CASE for grades
SELECT score, CASE
  WHEN score >= 90 THEN 'A'
  WHEN score >= 75 THEN 'B'
  ELSE 'C'
END AS grade FROM grades;

-- AVG score per course
SELECT c.name, AVG(g.score) FROM grades g JOIN enrollments e ON g.enroll_id = e.enroll_id JOIN courses c ON e.course_id = c.course_id GROUP BY c.name;

-- Courses with > 50 students
SELECT course_id, COUNT(*) FROM enrollments GROUP BY course_id HAVING COUNT(*) > 50;

-- IN clause
SELECT * FROM students WHERE student_id IN (SELECT student_id FROM enrollments WHERE course_id IN (101, 102));

-- Correlated subquery for top student per course
SELECT s.name, c.name FROM students s JOIN enrollments e ON s.student_id = e.student_id JOIN courses c ON e.course_id = c.course_id WHERE e.enroll_id IN (
  SELECT enroll_id FROM grades g WHERE g.score = (SELECT MAX(score) FROM grades g2 WHERE g2.enroll_id IN (SELECT enroll_id FROM enrollments WHERE course_id = c.course_id))
);