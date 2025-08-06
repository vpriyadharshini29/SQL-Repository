
-- Star Schema for Cinema Ticket Sales and Trends
CREATE TABLE fact_sales (
    sale_id INT PRIMARY KEY,
    time_id INT,
    store_id INT,
    product_id INT,
    customer_id INT,
    amount DECIMAL(10,2)
);

CREATE TABLE dim_time (
    time_id INT PRIMARY KEY,
    date DATE,
    month INT,
    quarter INT,
    year INT
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender CHAR(1),
    age INT
);
