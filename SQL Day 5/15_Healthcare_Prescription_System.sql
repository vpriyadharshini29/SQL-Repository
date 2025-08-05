-- Healthcare Prescription System

-- 1. Create Tables
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

CREATE TABLE medications (
    medication_id INT PRIMARY KEY,
    name VARCHAR(100),
    stock INT,
    optional_notes TEXT
);

CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    medication_id INT,
    dosage INT,
    date_prescribed DATE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id),
    CHECK (dosage >= 1 AND dosage <= 5)
);

-- 2. Insert Prescription with Dosage Constraint
INSERT INTO prescriptions (prescription_id, doctor_id, patient_id, medication_id, dosage, date_prescribed)
VALUES (1, 1, 101, 501, 2, CURRENT_DATE);

-- 3. Update Medication Stock
UPDATE medications
SET stock = stock - 1
WHERE medication_id = 501;

-- 4. Delete Prescriptions Older Than 6 Months
DELETE FROM prescriptions
WHERE date_prescribed < CURRENT_DATE - INTERVAL '6 months';

-- 5. CHECK (dosage >= 1 AND dosage <= 5) is already included above

-- 6. Modify and Drop NOT NULL on Optional Medication Field
-- First assume optional_notes is NOT NULL, then we drop it
ALTER TABLE medications ALTER COLUMN optional_notes DROP NOT NULL;

-- 7. Wrap Full Prescription Process in a Transaction
BEGIN;

-- Insert new patient
INSERT INTO patients (patient_id, name, age) VALUES (102, 'Rahul Dev', 45);

-- Insert medication if not exists
INSERT INTO medications (medication_id, name, stock, optional_notes)
VALUES (502, 'Paracetamol', 50, 'Take with food');

-- Insert prescription
INSERT INTO prescriptions (prescription_id, doctor_id, patient_id, medication_id, dosage, date_prescribed)
VALUES (2, 1, 102, 502, 3, CURRENT_DATE);

-- Decrease stock
UPDATE medications SET stock = stock - 1 WHERE medication_id = 502;

COMMIT;
