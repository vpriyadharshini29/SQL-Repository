-- Hospital Patient Monitoring System

CREATE TABLE patients (patient_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE appointments (appointment_id INT PRIMARY KEY, patient_id INT, doctor_id INT, department VARCHAR(100), appointment_date DATE);
CREATE TABLE doctors (doctor_id INT PRIMARY KEY, name VARCHAR(100));
CREATE TABLE treatments (treatment_id INT PRIMARY KEY, patient_id INT, cost DECIMAL(10,2), treatment_type VARCHAR(50));

-- Total patients per doctor (FROM subquery)
SELECT d.doctor_id, d.name, p.total FROM doctors d JOIN (
  SELECT doctor_id, COUNT(*) AS total FROM appointments GROUP BY doctor_id
) p ON d.doctor_id = p.doctor_id;

-- Patients treated > 3 times
SELECT patient_id FROM treatments GROUP BY patient_id HAVING COUNT(*) > 3;

-- CASE to flag critical patients
SELECT patient_id, COUNT(*) AS visits, SUM(cost) AS bill,
CASE
  WHEN COUNT(*) > 5 OR SUM(cost) > 10000 THEN 'Critical'
  ELSE 'Stable'
END AS status FROM treatments GROUP BY patient_id;

-- Correlated subquery: longest hospital stay per department
SELECT * FROM patients p WHERE patient_id IN (
  SELECT patient_id FROM appointments a1 WHERE department = a1.department
  ORDER BY DATEDIFF(MAX(appointment_date), MIN(appointment_date)) DESC LIMIT 1
);

-- Last 30 days patients
SELECT * FROM appointments WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- UNION outpatient and inpatient
SELECT * FROM outpatient_records
UNION
SELECT * FROM inpatient_records;