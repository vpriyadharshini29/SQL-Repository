-- Total enrollments per course
SELECT c.course_name, COUNT(e.enrollment_id) AS enrollment_count
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Average completion rate per instructor
SELECT i.first_name, AVG(e.completion_rate) AS avg_completion
FROM instructors i
INNER JOIN courses c ON i.instructor_id = c.instructor_id
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY i.first_name;

-- Courses with more than 20 completions
SELECT c.course_name, COUNT(e.enrollment_id) AS completion_count
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
WHERE e.completion_rate = 100
GROUP BY c.course_name
HAVING COUNT(e.enrollment_id) > 20;

-- INNER JOIN users and courses
SELECT u.first_name, c.course_name
FROM users u
INNER JOIN enrollments e ON u.user_id = e.user_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- LEFT JOIN courses without enrollments
SELECT c.course_name, e.enrollment_id
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

-- SELF JOIN users who completed same course
SELECT u1.first_name AS user1, u2.first_name AS user2, c.course_name
FROM enrollments e1
INNER JOIN enrollments e2 ON e1.course_id = e2.course_id AND e1.user_id < e2.user_id
INNER JOIN users u1 ON e1.user_id = u1.user_id
INNER JOIN users u2 ON e2.user_id = u2.user_id
INNER JOIN courses c ON e1.course_id = c.course_id
WHERE e1.completion_rate = 100 AND e2.completion_rate = 100;