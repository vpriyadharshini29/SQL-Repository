CREATE DATABASE course_portal;
USE course_portal;

CREATE TABLE instructors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  instructor_id INT,
  FOREIGN KEY (instructor_id) REFERENCES instructors(id)
);

CREATE TABLE registrations (
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Sample data
INSERT INTO instructors (name) VALUES ('Dr. Smith'), ('Dr. Allen'), ('Dr. Kim');
INSERT INTO students (name) VALUES ('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eve'), ('Frank'), ('Grace'), ('Helen');
INSERT INTO courses (title, instructor_id) VALUES ('Math 101', 1), ('Physics', 2), ('History', 3), ('Biology', 1), ('English', 2);

INSERT INTO registrations VALUES (1, 1), (2, 1), (3, 2), (4, 3), (5, 1);

-- Queries
SELECT course_id, COUNT(*) as student_count FROM registrations GROUP BY course_id;
SELECT * FROM students WHERE id NOT IN (SELECT DISTINCT student_id FROM registrations);
