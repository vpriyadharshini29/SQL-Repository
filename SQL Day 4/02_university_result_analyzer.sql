-- University Academic Result Analyzer

CREATE TABLE students (student_id INT PRIMARY KEY, name VARCHAR(100), enrolled_date DATE);
CREATE TABLE courses (course_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE subjects (subject_id INT PRIMARY KEY, name VARCHAR(100), course_id INT);
CREATE TABLE results (result_id INT PRIMARY KEY, student_id INT, subject_id INT, marks INT);

-- Students who scored above class average (subquery in WHERE)
SELECT * FROM results r WHERE marks > (SELECT AVG(marks) FROM results WHERE subject_id = r.subject_id);

-- FROM subquery for average marks per subject
SELECT * FROM (
  SELECT subject_id, AVG(marks) AS avg_marks FROM results GROUP BY subject_id
) avg_sub;

-- UNION ALL for midterm and final results
SELECT * FROM midterm_results
UNION ALL
SELECT * FROM final_results;

-- CASE grading
SELECT marks,
CASE
  WHEN marks >= 90 THEN 'A'
  WHEN marks >= 75 THEN 'B'
  WHEN marks >= 60 THEN 'C'
  ELSE 'F'
END AS grade FROM results;

-- JOIN and GROUP BY on course level
SELECT c.name, AVG(r.marks) FROM results r JOIN subjects s ON r.subject_id = s.subject_id JOIN courses c ON s.course_id = c.course_id GROUP BY c.name;

-- Students enrolled in the last year
SELECT * FROM students WHERE enrolled_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);