-- Table
CREATE TABLE routes (
  route_id INT,
  bus_no VARCHAR(20),
  origin VARCHAR(50),
  destination VARCHAR(50),
  departure TIME,
  arrival TIME,
  status VARCHAR(20)
);

-- Queries
SELECT bus_no, departure, arrival FROM routes WHERE origin = 'Coimbatore' AND destination = 'Madurai';
SELECT * FROM routes WHERE destination LIKE '%pur';
SELECT * FROM routes WHERE origin IN ('Coimbatore', 'Chennai', 'Trichy');
SELECT * FROM routes WHERE status IS NULL;
SELECT * FROM routes ORDER BY departure ASC;
