-- Event Management and Ticketing System

-- 1. Create Tables
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    title VARCHAR(100) UNIQUE,
    event_date DATE,
    age_restriction INT
);

CREATE TABLE attendees (
    attendee_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    event_id INT,
    attendee_id INT,
    ticket_type VARCHAR(50),
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id)
);

-- 2. Insert New Attendee Registrations
INSERT INTO attendees (attendee_id, name, age)
VALUES (1, 'John Doe', 25);

-- Register for an event
INSERT INTO tickets (ticket_id, event_id, attendee_id, ticket_type)
VALUES (1, 101, 1, 'VIP');

-- 3. Update Ticket Type or Event Date
UPDATE tickets
SET ticket_type = 'Premium'
WHERE ticket_id = 1;

UPDATE events
SET event_date = '2025-09-10'
WHERE event_id = 101;

-- 4. Delete Expired Events and Dependent Tickets
DELETE FROM events
WHERE event_date < CURRENT_DATE;

-- Tickets with ON DELETE CASCADE will be auto-deleted

-- 5. Enforce CHECK (age >= 18) for age-restricted events
ALTER TABLE attendees
ADD CONSTRAINT check_age CHECK (age >= 18);

-- 6. Modify a UNIQUE Constraint on Event Title
ALTER TABLE events DROP CONSTRAINT events_title_key;
ALTER TABLE events ADD CONSTRAINT unique_event_title UNIQUE (title);

-- 7. Transaction for Bulk Registrations; Rollback if Duplicates Found
BEGIN;

INSERT INTO attendees (attendee_id, name, age)
VALUES (2, 'Alice Smith', 30),
       (3, 'Bob Brown', 22);

SAVEPOINT bulk_insert;

-- Simulating potential duplicate registration (if attendee_id already exists)
INSERT INTO tickets (ticket_id, event_id, attendee_id, ticket_type)
VALUES 
    (2, 101, 2, 'Regular'),
    (3, 101, 3, 'Regular');

-- Let's say duplicate error found (simulate)
-- ROLLBACK TO SAVEPOINT bulk_insert;

COMMIT;
