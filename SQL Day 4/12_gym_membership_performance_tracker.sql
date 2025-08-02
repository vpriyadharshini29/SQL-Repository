-- Project 2: Gym Membership Performance Tracker

-- Average sessions per member
SELECT AVG(session_count) FROM (SELECT member_id, COUNT(*) AS session_count FROM sessions GROUP BY member_id) AS member_sessions;

-- CASE to bucket members by fitness goal completion
SELECT member_id, goals_achieved,
       CASE
           WHEN goals_achieved >= 5 THEN 'Achiever'
           WHEN goals_achieved BETWEEN 2 AND 4 THEN 'Progressing'
           ELSE 'Beginner'
       END AS fitness_category
FROM members;

-- Most active member per trainer
SELECT trainer_id, member_id
FROM sessions s1
WHERE session_count = (
    SELECT MAX(session_count)
    FROM (SELECT COUNT(*) AS session_count FROM sessions s2 WHERE s2.trainer_id = s1.trainer_id GROUP BY member_id) AS trainer_sessions
);

-- Session count per trainer
SELECT trainer_id, COUNT(*) AS session_count FROM sessions GROUP BY trainer_id;

-- Expired and active memberships
SELECT * FROM members WHERE membership_end < DATE('now')
UNION ALL
SELECT * FROM members WHERE membership_end >= DATE('now');

-- Memberships expiring this month
SELECT * FROM members WHERE strftime('%Y-%m', membership_end) = strftime('%Y-%m', 'now');
