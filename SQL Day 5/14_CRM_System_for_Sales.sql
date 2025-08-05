-- CRM System for Sales

-- 1. Create Tables
CREATE TABLE leads (
    lead_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    status VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    lead_id INT,
    customer_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (lead_id) REFERENCES leads(lead_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE followups (
    followup_id INT PRIMARY KEY,
    lead_id INT,
    followup_count INT,
    FOREIGN KEY (lead_id) REFERENCES leads(lead_id),
    CHECK (followup_count <= 5)
);

-- 2. Insert Lead Records with UNIQUE Phone/Email
INSERT INTO leads (lead_id, name, phone, email, status)
VALUES (1, 'Priya Kumar', '9876543210', 'priya@example.com', 'Interested');

-- 3. Update Lead Status After Sales Conversion
UPDATE leads
SET status = 'Converted'
WHERE lead_id = 1;

-- 4. Delete Old Leads After 1 Year
DELETE FROM leads
WHERE status != 'Converted' AND CURRENT_DATE - INTERVAL '1 year' > CURRENT_DATE;

-- 5. Add CHECK (followup_count <= 5) already in table definition

-- 6. Drop and Reapply FOREIGN KEY on sales
ALTER TABLE sales DROP CONSTRAINT sales_lead_id_fkey;
ALTER TABLE sales ADD CONSTRAINT fk_sales_lead FOREIGN KEY (lead_id) REFERENCES leads(lead_id);

-- 7. Use Transaction to Convert Lead → Customer + Log Sale
BEGIN;

-- Insert into customers
INSERT INTO customers (customer_id, name, phone, email)
SELECT 101, name, phone, email FROM leads WHERE lead_id = 1;

-- Insert sale
INSERT INTO sales (sale_id, lead_id, customer_id, amount)
VALUES (1, 1, 101, 25000.00);

COMMIT;
