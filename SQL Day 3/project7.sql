-- Total views per movie
SELECT m.title, COUNT(v.view_id) AS view_count
FROM movies m
INNER JOIN views v ON m.movie_id = v.movie_id
GROUP BY m.title;

-- Average watch time per genre
SELECT m.genre, AVG(v.watch_duration) AS avg_watch_time
FROM movies m
INNER JOIN views v ON m.movie_id = v.movie_id
GROUP BY m.genre;

-- Movies with more than 500 views
SELECT m.title, COUNT(v.view_id) AS view_count
FROM movies m
INNER JOIN views v ON m.movie_id = v.movie_id
GROUP BY m.title
HAVING COUNT(v.view_id) > 500;

-- INNER JOIN views and movies
SELECT m.title, v.view_date
FROM movies m
INNER JOIN views v ON m.movie_id = v.movie_id;

-- LEFT JOIN users and subscriptions
SELECT u.user_id, u.first_name, s.plan_name
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id;

-- SELF JOIN users with same subscription plan
SELECT u1.first_name AS user1, u2.first_name AS user2, s.plan_name
FROM subscriptions s1
INNER JOIN subscriptions s2 ON s1.plan_name = s2.plan_name AND s1.user_id < s2.user_id
INNER JOIN users u1 ON s1.user_id = u1.user_id
INNER JOIN users u2 ON s2.user_id = u2.user_id;