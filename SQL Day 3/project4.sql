-- Total patients treated per doctor
SELECT d.doctor_id, d.first_name, COUNT(a.appointment_id) AS patient_count
FROM doctors d
INNER JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name;

-- Average treatment cost per doctor
SELECT d.doctor_id, d.first_name, AVG(t.cost) AS avg_cost
FROM doctors d
INNER JOIN appointments a ON d.doctor_id = a.doctor_id
INNER JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, d.first_name;

-- Doctors who treated more than 10 patients
SELECT d.doctor_id, d.first_name, COUNT(a.appointment_id) AS patient_count
FROM doctors d
INNER JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name
HAVING COUNT(a.appointment_id) > 10;

-- INNER JOIN appointments and doctors
SELECT a.appointment_id, d.first_name, p.first_name AS patient_name
FROM appointments a
INNER JOIN doctors d ON a.doctor_id = d.doctor_id
INNER JOIN patients p ON a.patient_id = p.patient_id;

-- RIGHT JOIN all doctors, including those with no appointments
SELECT d.first_name, a.appointment_id
FROM appointments a
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id;

-- SELF JOIN patients with same birth date
SELECT p1.first_name AS patient1, p2.first_name AS patient2, p1.birth_date
FROM patients p1
INNER JOIN patients p2 ON p1.birth_date = p2.birth_date AND p1.patient_id < p2.patient_id;