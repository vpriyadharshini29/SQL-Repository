-- Project 4: Event Registration and Attendance Tracker

-- Feedback rating per event
SELECT event_id, AVG(rating) AS avg_rating FROM feedback GROUP BY event_id;

-- Classify events based on turnout percentage
SELECT e.event_id, e.capacity, COUNT(r.attendee_id) AS turnout,
       CASE
           WHEN COUNT(r.attendee_id)*100.0 / e.capacity >= 80 THEN 'Popular'
           WHEN COUNT(r.attendee_id)*100.0 / e.capacity >= 50 THEN 'Moderate'
           ELSE 'Low'
       END AS turnout_category
FROM events e
LEFT JOIN registrations r ON e.event_id = r.event_id
GROUP BY e.event_id;

-- Online and offline events
SELECT * FROM events WHERE mode = 'Online'
UNION ALL
SELECT * FROM events WHERE mode = 'Offline';

-- Top participant per event
SELECT event_id, attendee_id
FROM registrations r1
WHERE attendee_id = (
    SELECT attendee_id
    FROM registrations r2
    WHERE r1.event_id = r2.event_id
    GROUP BY attendee_id
    ORDER BY COUNT(*) DESC LIMIT 1
);

-- Event-wise engagement
SELECT e.event_id, COUNT(f.feedback_id) AS feedback_count
FROM events e
LEFT JOIN feedback f ON e.event_id = f.event_id
GROUP BY e.event_id;

-- Upcoming events
SELECT * FROM events WHERE event_date >= DATE('now');
