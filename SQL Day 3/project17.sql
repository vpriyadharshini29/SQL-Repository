-- Count of tickets per technician
SELECT t.first_name, COUNT(ti.ticket_id) AS ticket_count
FROM technicians t
INNER JOIN tickets ti ON t.technician_id = ti.technician_id
GROUP BY t.first_name;

-- Average resolution time
SELECT t.first_name, AVG(DATEDIFF(ti.resolved_date, ti.created_date)) AS avg_resolution_time
FROM technicians t
INNER JOIN tickets ti ON t.technician_id = ti.technician_id
WHERE ti.resolved_date IS NOT NULL
GROUP BY t.first_name;

-- Techs handling more than 10 tickets
SELECT t.first_name, COUNT(ti.ticket_id) AS ticket_count
FROM technicians t
INNER JOIN tickets ti ON t.technician_id = ti.technician_id
GROUP BY t.first_name
HAVING COUNT(ti.ticket_id) > 10;

-- INNER JOIN tickets and technicians
SELECT t.first_name, ti.ticket_id, ti.created_date
FROM technicians t
INNER JOIN tickets ti ON t.technician_id = ti.technician_id;

-- LEFT JOIN clients and tickets
SELECT c.first_name, ti.ticket_id
FROM clients c
LEFT JOIN tickets ti ON c.client_id = ti.client_id;

-- SELF JOIN tickets with same issue types
SELECT ti1.ticket_id AS ticket1, ti2.ticket_id AS ticket2, ti1.issue_type
FROM tickets ti1
INNER JOIN tickets ti2 ON ti1.issue_type = ti2.issue_type AND ti1.ticket_id < ti2.ticket_id;