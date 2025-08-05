-- School Student & Grade Management

-- 1. Create Tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    class VARCHAR(10)
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);

CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    grade INT CHECK (grade BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- 2. Insert Grades
INSERT INTO grades (grade_id, student_id, subject_id, grade)
VALUES (1, 101, 201, 85);

-- 3. Update Grade on Retest
UPDATE grades
SET grade = 92
WHERE grade_id = 1;

-- 4. Delete Grades for Withdrawn Students
DELETE FROM grades
WHERE student_id = 102;

-- 5. Modify Grade Scale (0–150)
ALTER TABLE grades
DROP CONSTRAINT grades_grade_check;

ALTER TABLE grades
ADD CONSTRAINT grades_grade_check CHECK (grade BETWEEN 0 AND 150);

-- 6. Batch Insert/Update with Transactions
BEGIN;

-- Insert new grade
INSERT INTO grades (grade_id, student_id, subject_id, grade)
VALUES (2, 103, 202, 78);

-- Update grade
UPDATE grades
SET grade = 95
WHERE grade_id = 1;

-- Simulate error
-- ROLLBACK;
COMMIT;
