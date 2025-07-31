-- Table
CREATE TABLE appointments (
  appointment_id INT,
  patient_name VARCHAR(100),
  doctor_name VARCHAR(100),
  date DATE,
  status VARCHAR(20),
  notes TEXT
);

-- Queries
SELECT doctor_name, date, status FROM appointments WHERE date BETWEEN '2025-07-28' AND '2025-08-03';
SELECT * FROM appointments WHERE patient_name LIKE '%th%';
SELECT * FROM appointments WHERE notes IS NULL;
SELECT DISTINCT doctor_name FROM appointments;
SELECT * FROM appointments ORDER BY date DESC;
