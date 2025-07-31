CREATE DATABASE hospital_db;
USE hospital_db;

CREATE TABLE departments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100)
);

CREATE TABLE doctors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE patients (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100)
);

CREATE TABLE appointments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  appointment_date DATE,
  patient_id INT,
  doctor_id INT,
  FOREIGN KEY (patient_id) REFERENCES patients(id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

-- Sample data
INSERT INTO departments (name) VALUES ('Cardiology'), ('Neurology');
INSERT INTO doctors (name, department_id) VALUES 
('Dr. A', 1), ('Dr. B', 2), ('Dr. C', 1), ('Dr. D', 2), ('Dr. E', 1),
('Dr. F', 2), ('Dr. G', 1), ('Dr. H', 2), ('Dr. I', 1), ('Dr. J', 2);

INSERT INTO patients (name) VALUES 
('P1'), ('P2'), ('P3'), ('P4'), ('P5'),
('P6'), ('P7'), ('P8'), ('P9'), ('P10'),
('P11'), ('P12'), ('P13'), ('P14'), ('P15');

-- Example appointments
INSERT INTO appointments (appointment_date, patient_id, doctor_id) VALUES
('2025-07-30', 1, 1), ('2025-07-30', 2, 2), ('2025-08-01', 3, 3),
('2025-08-02', 4, 4), ('2025-08-03', 5, 5), ('2025-08-04', 6, 6),
('2025-08-05', 7, 7), ('2025-08-06', 8, 8), ('2025-08-07', 9, 9),
('2025-08-08', 10, 10), ('2025-08-09', 11, 1), ('2025-08-10', 12, 2),
('2025-08-11', 13, 3), ('2025-08-12', 14, 4), ('2025-08-13', 15, 5);

-- Queries
SELECT * FROM appointments WHERE appointment_date = '2025-07-30';
SELECT * FROM doctors WHERE department_id = 1;
SELECT doctor_id, COUNT(*) FROM appointments GROUP BY doctor_id;
