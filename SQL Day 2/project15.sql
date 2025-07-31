-- Table
CREATE TABLE pets (
  pet_id INT,
  name VARCHAR(100),
  species VARCHAR(50),
  breed VARCHAR(50),
  age INT,
  adopted BOOLEAN,
  owner_name VARCHAR(100)
);

-- Queries
SELECT name, breed, species FROM pets WHERE adopted = FALSE AND age BETWEEN 1 AND 5;
SELECT * FROM pets WHERE breed LIKE '%shepherd%';
SELECT * FROM pets WHERE owner_name IS NULL;
SELECT DISTINCT species FROM pets;
SELECT * FROM pets ORDER BY age ASC, name ASC;
