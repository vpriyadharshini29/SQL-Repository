CREATE DATABASE exam_db;
USE exam_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Sample Queries
-- Calculate average marks
SELECT student_id, AVG(marks) AS average_marks
FROM marks
GROUP BY student_id;

-- Rank students by subject
SELECT subject_id, student_id, marks,
       RANK() OVER (PARTITION BY subject_id ORDER BY marks DESC) AS rank
FROM marks;
