CREATE DATABASE voting_db;
USE voting_db;

CREATE TABLE elections (
    election_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    date DATE
);

CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    election_id INT,
    FOREIGN KEY (election_id) REFERENCES elections(election_id)
);

CREATE TABLE voters (
    voter_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE votes (
    vote_id INT PRIMARY KEY AUTO_INCREMENT,
    voter_id INT,
    candidate_id INT,
    election_id INT,
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id),
    FOREIGN KEY (election_id) REFERENCES elections(election_id),
    UNIQUE (voter_id, election_id)
);

-- Sample Queries
-- Count votes per candidate
SELECT candidate_id, COUNT(*) AS vote_count
FROM votes
GROUP BY candidate_id;

-- Find election winners
SELECT election_id, candidate_id, COUNT(*) AS votes
FROM votes
GROUP BY election_id, candidate_id
ORDER BY votes DESC;

-- Update vote record
UPDATE votes
SET candidate_id = 2
WHERE vote_id = 1;
