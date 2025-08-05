-- Voting Registration & Results System

-- 1. Create Tables
CREATE TABLE voters (
    voter_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    UNIQUE (voter_id),
    CHECK (age >= 18)
);

CREATE TABLE elections (
    election_id INT PRIMARY KEY,
    name VARCHAR(100),
    election_date DATE
);

CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY,
    name VARCHAR(100),
    election_id INT,
    FOREIGN KEY (election_id) REFERENCES elections(election_id)
);

CREATE TABLE votes (
    vote_id INT PRIMARY KEY,
    voter_id INT,
    candidate_id INT,
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id)
);

-- 2. Insert Voter Details with UNIQUE ID
INSERT INTO voters (voter_id, name, age)
VALUES (101, 'Arjun Rao', 26);

-- 3. Update Vote Status After Submission
-- (Assuming vote status is stored by inserting into votes table)
INSERT INTO votes (vote_id, voter_id, candidate_id)
VALUES (1, 101, 201);

-- 4. Delete Invalid Votes Using FOREIGN KEY CASCADE
-- Deleting a voter will delete related vote automatically
DELETE FROM voters WHERE voter_id = 101;

-- 5. CHECK (age >= 18) already enforced during table creation

-- 6. Modify Constraints to Allow Re-voting in Test Mode
-- First drop the voter_id + candidate_id unique constraint if it exists (simulate re-voting scenario)
-- Only do this in test mode
-- (This assumes there was a UNIQUE constraint previously added, e.g., UNIQUE(voter_id, election_id))

-- Example of modifying:
-- ALTER TABLE votes DROP CONSTRAINT unique_vote_once;

-- 7. Use Transaction for Cast + Log + Confirmation
BEGIN;

-- Insert vote
INSERT INTO votes (vote_id, voter_id, candidate_id)
VALUES (2, 102, 202);

-- Simulate logging (another table would exist in real system)
-- For now, we’ll simulate with a message (not executable SQL)

-- Confirm vote submission (if no error)
COMMIT;
