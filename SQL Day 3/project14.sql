-- Average calories burned per workout
SELECT w.workout_type, AVG(w.calories_burned) AS avg_calories
FROM workouts w
GROUP BY w.workout_type;

-- Users with > 10 sessions
SELECT u.first_name, COUNT(w.workout_id) AS session_count
FROM users u
INNER JOIN workouts w ON u.user_id = w.user_id
GROUP BY u.first_name
HAVING COUNT(w.workout_id) > 10;

-- INNER JOIN users and workouts
SELECT u.first_name, w.workout_type, w.workout_date
FROM users u
INNER JOIN workouts w ON u.user_id = w.user_id;

-- LEFT JOIN trainers and users
SELECT t.first_name AS trainer, u.first_name AS user
FROM trainers t
LEFT JOIN users u ON t.trainer_id = u.trainer_id;

-- SELF JOIN users with similar goals
SELECT u1.first_name AS user1, u2.first_name AS user2, g.goal_type
FROM goals g1
INNER JOIN goals g2 ON g1.goal_type = g2.goal_type AND g1.user_id < g2.user_id
INNER JOIN users u1 ON g1.user_id = u1.user_id
INNER JOIN users u2 ON g2.user_id = u2.user_id;