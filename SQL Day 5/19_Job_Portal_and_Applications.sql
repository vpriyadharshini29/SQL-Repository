-- Job Portal and Applications

-- 1. Create Tables
CREATE TABLE jobs (
    job_id INT PRIMARY KEY,
    title VARCHAR(100),
    company VARCHAR(100),
    deadline DATE
);

CREATE TABLE applicants (
    applicant_id INT PRIMARY KEY,
    name VARCHAR(100),
    experience INT CHECK (experience >= 0)
);

CREATE TABLE recruiters (
    recruiter_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE applications (
    application_id INT PRIMARY KEY,
    job_id INT,
    applicant_id INT,
    status VARCHAR(50),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (applicant_id) REFERENCES applicants(applicant_id),
    UNIQUE (job_id, applicant_id)
);

-- 2. Insert Applications with Duplicate Prevention
INSERT INTO applications (application_id, job_id, applicant_id, status)
VALUES (1, 101, 201, 'Applied');

-- The UNIQUE constraint on (job_id, applicant_id) prevents duplicates

-- 3. Update Status to Interview, Rejected, etc.
UPDATE applications
SET status = 'Interview Scheduled'
WHERE application_id = 1;

-- 4. Delete Applications Post Deadline
DELETE FROM applications
WHERE job_id IN (
    SELECT job_id FROM jobs WHERE deadline < CURRENT_DATE
);

-- 5. CHECK (experience >= 0) already added during table creation

-- 6. Drop and Recreate CHECK Constraint to Change Experience Rule
-- Drop old CHECK constraint (example name: chk_experience)
-- ALTER TABLE applicants DROP CONSTRAINT chk_experience;

-- Add new CHECK constraint: max 40 years of experience
-- ALTER TABLE applicants ADD CONSTRAINT chk_experience_new CHECK (experience BETWEEN 0 AND 40);

-- 7. Transaction to Post Job + Notify Applicants
BEGIN;

-- Insert job
INSERT INTO jobs (job_id, title, company, deadline)
VALUES (102, 'Frontend Developer', 'TechCorp', '2025-12-01');

-- Notify applicants (simulate with log or actual messaging system in real-world)
-- Here we just simulate insert
INSERT INTO applications (application_id, job_id, applicant_id, status)
VALUES (2, 102, 202, 'Notified');

COMMIT;
