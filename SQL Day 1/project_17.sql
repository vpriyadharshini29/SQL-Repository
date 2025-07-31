CREATE DATABASE job_portal_db;
USE job_portal_db;

CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE jobs (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

CREATE TABLE applicants (
    applicant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    applicant_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (applicant_id) REFERENCES applicants(applicant_id)
);

-- Sample Queries
-- Find all jobs a user has applied for
SELECT a.name, j.title
FROM applications ap
JOIN jobs j ON ap.job_id = j.job_id
JOIN applicants a ON ap.applicant_id = a.applicant_id;

-- Count applications per company
SELECT c.name, COUNT(*) AS total_applications
FROM applications ap
JOIN jobs j ON ap.job_id = j.job_id
JOIN companies c ON j.company_id = c.company_id
GROUP BY c.name;
