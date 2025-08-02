-- Hospital Patient Visit Tracker

CREATE TABLE patients (patient_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE doctors (doctor_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE departments (dept_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE appointments (appointment_id INT PRIMARY KEY, patient_id INT, doctor_id INT, dept_id INT, visit_date DATE, emergency BOOLEAN, FOREIGN KEY(patient_id) REFERENCES patients(patient_id), FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id), FOREIGN KEY(dept_id) REFERENCES departments(dept_id));

-- LEFT JOIN to show all patients even with no appointments
SELECT p.name, a.visit_date FROM patients p LEFT JOIN appointments a ON p.patient_id = a.patient_id;

-- BETWEEN for date range
SELECT * FROM appointments WHERE visit_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Visit count per department
SELECT d.name, COUNT(*) AS visit_count FROM appointments a JOIN departments d ON a.dept_id = d.dept_id GROUP BY d.name;

-- FULL OUTER JOIN
SELECT * FROM appointments a FULL OUTER JOIN doctors d ON a.doctor_id = d.doctor_id;

-- Subquery in FROM for daily appointments
SELECT visit_date, COUNT(*) AS daily_visits FROM appointments GROUP BY visit_date;

-- CASE for emergency flag
SELECT *, CASE WHEN emergency THEN 'Emergency' ELSE 'Routine' END AS visit_type FROM appointments;

-- UNION regular and emergency visits
SELECT * FROM appointments WHERE emergency = FALSE
UNION
SELECT * FROM appointments WHERE emergency = TRUE;