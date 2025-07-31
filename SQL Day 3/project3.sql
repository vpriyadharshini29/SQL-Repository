-- Count enrollments per course
SELECT c.course_name, COUNT(e.enrollment_id) AS enrollment_count
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Average grade per course
SELECT c.course_name, AVG(e.grade) AS avg_grade
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Courses with avg grade > 75
SELECT c.course_name, AVG(e.grade) AS avg_grade
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING AVG(e.grade) > 75;

-- INNER JOIN students and course grades
SELECT s.first_name, c.course_name, e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- LEFT JOIN courses without enrollments
SELECT c.course_name, e.enrollment_id
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

-- SELF JOIN for peer pairing (same course, same grade)
SELECT s1.first_name AS student1, s2.first_name AS student2, c.course_name, e1.grade
FROM enrollments e1
INNER JOIN enrollments e2 ON e1.course_id = e2.course_id AND e1.grade = e2.grade AND e1.student_id < e2.student_id
INNER JOIN students s1 ON e1.student_id = s1.student_id
INNER JOIN students s2 ON e2.student_id = s2.student_id
INNER JOIN courses c ON e1.course_id = c.course_id;