-- Hospital Management System

-- 1. Create Tables
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age BETWEEN 0 AND 120),
    gender VARCHAR(10) NOT NULL
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 2. Insert New Patient Details
INSERT INTO patients (patient_id, name, age, gender)
VALUES (1, 'John Doe', 35, 'Male');

-- 3. Update Doctor Specialization and Department
UPDATE doctors
SET specialization = 'Cardiologist', department_id = 1
WHERE doctor_id = 1;

-- 4. Delete Patient and Associated Appointments
SAVEPOINT before_delete_patient;

DELETE FROM patients WHERE patient_id = 1;

-- If needed, rollback:
-- ROLLBACK TO before_delete_patient;

-- 5. Atomic Update for Doctor & Appointment
BEGIN TRANSACTION;

UPDATE doctors
SET specialization = 'Neurologist'
WHERE doctor_id = 2;

UPDATE appointments
SET appointment_date = '2025-08-10'
WHERE appointment_id = 3;

COMMIT;
