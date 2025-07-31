-- Create database
CREATE DATABASE IF NOT EXISTS gym_db;
USE gym_db;

-- Plans table
CREATE TABLE plans (
  plan_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) UNIQUE NOT NULL,
  duration_months INT,
  price DECIMAL(8,2)
);

-- Trainers table
CREATE TABLE trainers (
  trainer_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  specialization VARCHAR(100)
);

-- Members table
CREATE TABLE members (
  member_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  plan_id INT,
  trainer_id INT,
  FOREIGN KEY (plan_id) REFERENCES plans(plan_id),
  FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);

-- Subscriptions table
CREATE TABLE subscriptions (
  sub_id INT PRIMARY KEY AUTO_INCREMENT,
  member_id INT,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Insert plans
INSERT INTO plans (name, duration_months, price) VALUES
('Basic', 1, 1000.00),
('Standard', 3, 2700.00),
('Premium', 6, 5000.00),
('Annual', 12, 9000.00),
('Weight Loss', 3, 3000.00);

-- Insert trainers
INSERT INTO trainers (name, specialization) VALUES
('Arun', 'Weight Training'),
('Sneha', 'Yoga'),
('Rahul', 'Cardio');

-- Insert members
INSERT INTO members (name, plan_id, trainer_id) VALUES
('Anu', 1, 1), ('Ravi', 2, 2), ('Priya', 3, 3),
('Karan', 4, 1), ('Sneha', 5, 2), ('Vivek', 1, 3),
('Meera', 2, 1), ('Neha', 3, 2), ('Vikram', 5, 3), ('Lakshmi', 4, 1);

-- Insert subscriptions
INSERT INTO subscriptions (member_id, start_date, end_date) VALUES
(1, '2025-05-01', '2025-06-01'),
(2, '2025-04-01', '2025-07-01'),
(3, '2025-01-01', '2025-07-01'),
(4, '2024-07-01', '2025-07-01'),
(5, '2025-06-01', '2025-09-01');

-- UPDATE to upgrade plan (e.g., member 1 from Basic to Premium)
UPDATE members SET plan_id = 3 WHERE member_id = 1;

-- DELETE expired subscriptions (assuming today is 2025-07-30)
DELETE FROM subscriptions WHERE end_date < '2025-07-30';
