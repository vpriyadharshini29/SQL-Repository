-- Total plays per song
SELECT s.title, COUNT(p.play_id) AS play_count
FROM songs s
INNER JOIN plays p ON s.song_id = p.song_id
GROUP BY s.title;

-- Average play duration per genre
SELECT s.genre, AVG(p.play_duration) AS avg_play_duration
FROM songs s
INNER JOIN plays p ON s.song_id = p.song_id
GROUP BY s.genre;

-- Artists with songs played > 1,000 times
SELECT a.artist_name, COUNT(p.play_id) AS play_count
FROM artists a
INNER JOIN songs s ON a.artist_id = s.artist_id
INNER JOIN plays p ON s.song_id = p.song_id
GROUP BY a.artist_name
HAVING COUNT(p.play_id) > 1000;

-- INNER JOIN songs and plays
SELECT s.title, p.play_date
FROM songs s
INNER JOIN plays p ON s.song_id = p.song_id;

-- RIGHT JOIN listeners and plays
SELECT l.first_name, p.play_id
FROM plays p
RIGHT JOIN listeners l ON p.listener_id = l.listener_id;

-- SELF JOIN listeners with similar genres
SELECT l1.first_name AS listener1, l2.first_name AS listener2, s.genre
FROM plays p1
INNER JOIN plays p2 ON p1.song_id = p2.song_id AND p1.listener_id < p2.listener_id
INNER JOIN songs s ON p1.song_id = s.song_id
INNER JOIN listeners l1 ON p1.listener_id = l1.listener_id
INNER JOIN listeners l2 ON p2.listener_id = l2.listener_id;