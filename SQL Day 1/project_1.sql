-- Create database
CREATE DATABASE school_db;
USE school_db;

-- Create tables
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject VARCHAR(100)
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert data
INSERT INTO students (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com'),
('David', 'david@example.com'),
('Eva', 'eva@example.com'),
('Frank', 'frank@example.com'),
('Grace', 'grace@example.com'),
('Hank', 'hank@example.com'),
('Ivy', 'ivy@example.com'),
('Jack', 'jack@example.com');

INSERT INTO courses (course_name) VALUES 
('Mathematics'), ('Science'), ('History'), ('Geography'), ('Art');

INSERT INTO teachers (name, subject) VALUES 
('Mr. Smith', 'Mathematics'),
('Ms. Johnson', 'Science'),
('Mrs. Lee', 'History'),
('Mr. Brown', 'Geography'),
('Ms. Clark', 'Art');

INSERT INTO enrollments (student_id, course_id) VALUES 
(1, 1), (1, 2), (2, 3), (3, 1), (4, 2), (5, 3), (6, 4), (7, 5), (8, 1), (9, 2);

-- CRUD examples
-- Add student
INSERT INTO students (name, email) VALUES ('New Student', 'new@example.com');

-- Assign course to student
INSERT INTO enrollments (student_id, course_id) VALUES (10, 5);

-- Update teacher info
UPDATE teachers SET subject = 'Advanced Science' WHERE name = 'Ms. Johnson';

-- SELECT queries
-- List students per course
SELECT c.course_name, s.name 
FROM enrollments e 
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Count students by course
SELECT c.course_name, COUNT(e.student_id) AS student_count 
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- Students with no enrollments
SELECT s.name FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;