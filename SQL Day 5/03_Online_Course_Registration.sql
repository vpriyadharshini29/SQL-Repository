-- Online Course Registration System

-- 1. Create Tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    available_seats INT
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade INT CHECK (grade BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 2. Insert with FOREIGN KEY Checks
INSERT INTO enrollments (enrollment_id, student_id, course_id, grade)
VALUES (1, 1, 101, 85);

-- 3. Update Course Availability
UPDATE courses
SET available_seats = available_seats - 1
WHERE course_id = 101;

-- 4. Delete Student with ON DELETE CASCADE
DELETE FROM students WHERE student_id = 1;

-- 5. Drop and Recreate Grade Constraint
ALTER TABLE enrollments DROP CONSTRAINT enrollments_grade_check;
ALTER TABLE enrollments ADD CONSTRAINT enrollments_grade_check CHECK (grade BETWEEN 0 AND 150);

-- 6. Bulk Enrollment in Transaction
BEGIN;

INSERT INTO enrollments (enrollment_id, student_id, course_id, grade)
VALUES (2, 2, 102, 90),
       (3, 3, 103, 88);

-- Simulate error
-- INSERT INTO enrollments (enrollment_id, student_id, course_id, grade)
-- VALUES (4, 999, 102, 80); -- Fails due to FK

-- If error:
-- ROLLBACK;

COMMIT;

-- 7. Consistency: Partial Update Rollback
BEGIN;

UPDATE students SET name = 'Updated Name' WHERE student_id = 2;
UPDATE enrollments SET grade = 95 WHERE enrollment_id = 2;

-- Simulated failure
-- ROLLBACK;

-- COMMIT;
