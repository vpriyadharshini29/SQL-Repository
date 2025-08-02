-- Music Streaming Service

CREATE TABLE users (user_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE artists (artist_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE songs (song_id INT PRIMARY KEY, title VARCHAR(100), artist_id INT, FOREIGN KEY(artist_id) REFERENCES artists(artist_id));
CREATE TABLE play_history (play_id INT PRIMARY KEY, user_id INT, song_id INT, play_time TIMESTAMP, FOREIGN KEY(user_id) REFERENCES users(user_id), FOREIGN KEY(song_id) REFERENCES songs(song_id));

-- Who listened to what
SELECT u.name, s.title FROM play_history p JOIN users u ON p.user_id = u.user_id JOIN songs s ON p.song_id = s.song_id;

-- Top songs
SELECT s.title, COUNT(*) AS play_count FROM play_history p JOIN songs s ON p.song_id = s.song_id GROUP BY s.title ORDER BY play_count DESC;

-- Most played artists
SELECT a.name, COUNT(*) AS play_count FROM play_history p JOIN songs s ON p.song_id = s.song_id JOIN artists a ON s.artist_id = a.artist_id GROUP BY a.name ORDER BY play_count DESC;

-- Users who listened >10 times to same artist
SELECT user_id FROM (
  SELECT p.user_id, s.artist_id, COUNT(*) AS plays FROM play_history p JOIN songs s ON p.song_id = s.song_id GROUP BY p.user_id, s.artist_id
) sub WHERE plays > 10;

-- CASE for listener label
SELECT user_id, COUNT(*) AS total_plays,
CASE
  WHEN COUNT(*) >= 100 THEN 'Heavy'
  WHEN COUNT(*) >= 50 THEN 'Moderate'
  ELSE 'Light'
END AS listener_type FROM play_history GROUP BY user_id;

-- Filter romantic songs
SELECT * FROM songs WHERE title LIKE '%Love%';