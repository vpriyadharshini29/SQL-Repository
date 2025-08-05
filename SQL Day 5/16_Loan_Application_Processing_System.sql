-- Loan Application Processing System

-- 1. Create Tables
CREATE TABLE applicants (
    applicant_id INT PRIMARY KEY,
    name VARCHAR(100),
    credit_score INT
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    applicant_id INT,
    amount DECIMAL(12,2),
    status VARCHAR(50),
    FOREIGN KEY (applicant_id) REFERENCES applicants(applicant_id),
    CHECK (amount <= 1000000)
);

CREATE TABLE documents (
    document_id INT PRIMARY KEY,
    applicant_id INT,
    doc_type VARCHAR(100),
    status VARCHAR(50),
    FOREIGN KEY (applicant_id) REFERENCES applicants(applicant_id)
);

CREATE TABLE disbursements (
    disbursement_id INT PRIMARY KEY,
    loan_id INT,
    disbursement_date DATE,
    amount DECIMAL(12,2),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

-- 2. Insert Application With Constraints
INSERT INTO applicants (applicant_id, name, credit_score)
VALUES (1, 'Sanya Mehta', 720);

INSERT INTO loans (loan_id, applicant_id, amount, status)
VALUES (1, 1, 800000.00, 'Applied');

-- 3. Update Status Through Stages
UPDATE loans SET status = 'Approved' WHERE loan_id = 1;

-- 4. Delete Unverified Applications
DELETE FROM loans
WHERE status = 'Unverified';

-- 5. CHECK (amount <= 1,000,000) is already added in table creation

-- 6. Use SAVEPOINT Before Disbursement
BEGIN;

SAVEPOINT before_disbursement;

-- Insert disbursement
INSERT INTO disbursements (disbursement_id, loan_id, disbursement_date, amount)
VALUES (1, 1, CURRENT_DATE, 800000.00);

-- Rollback if amount disbursed is more than loan
DO $$
BEGIN
    IF (SELECT amount FROM disbursements WHERE disbursement_id = 1) >
       (SELECT amount FROM loans WHERE loan_id = 1) THEN
        RAISE NOTICE 'Rolling back...';
        ROLLBACK TO SAVEPOINT before_disbursement;
    END IF;
END;
$$;

COMMIT;

-- 7. Transaction: verify docs, approve, disburse – rollback if any fail
BEGIN;

-- Update document status
UPDATE documents SET status = 'Verified' WHERE applicant_id = 1;

-- Approve loan
UPDATE loans SET status = 'Final Approved' WHERE loan_id = 1;

-- Disbursement
INSERT INTO disbursements (disbursement_id, loan_id, disbursement_date, amount)
VALUES (2, 1, CURRENT_DATE, 800000.00);

COMMIT;
