-- Project 9: Job Portal Applicant Matching

-- Jobs applied by applicants with > 3 applications
SELECT job_id
FROM applications
WHERE applicant_id IN (
    SELECT applicant_id
    FROM applications
    GROUP BY applicant_id
    HAVING COUNT(*) > 3
);

-- Application status labeling
SELECT application_id, status,
       CASE status
           WHEN 'Shortlisted' THEN 'Shortlisted'
           WHEN 'Rejected' THEN 'Rejected'
           ELSE 'In Review'
       END AS application_status
FROM applications;

-- Applications per job
SELECT job_id, COUNT(*) AS total_applications
FROM applications
GROUP BY job_id;

-- Full-time and internship roles
SELECT * FROM jobs WHERE job_type = 'Full-time'
UNION
SELECT * FROM jobs WHERE job_type = 'Internship';

-- Most applied job per applicant
SELECT applicant_id, job_id
FROM (
    SELECT applicant_id, job_id, COUNT(*) AS app_count,
           RANK() OVER (PARTITION BY applicant_id ORDER BY COUNT(*) DESC) AS rnk
    FROM applications
    GROUP BY applicant_id, job_id
) WHERE rnk = 1;

-- Recent applications
SELECT * FROM applications WHERE application_date >= DATE('now', '-30 days');
