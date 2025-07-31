CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE brands (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  brand_id INT,
  category_id INT,
  FOREIGN KEY (brand_id) REFERENCES brands(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE favorites (
  user_id INT,
  product_id INT,
  PRIMARY KEY (user_id, product_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Sample data
INSERT INTO categories (name) VALUES ('Electronics'), ('Clothing'), ('Books');
INSERT INTO brands (name) VALUES ('Sony'), ('Nike'), ('Penguin');
INSERT INTO users (username) VALUES ('alice'), ('bob');

INSERT INTO products (name, price, brand_id, category_id) VALUES
('Headphones', 49.99, 1, 1),
('T-shirt', 19.99, 2, 2),
('Novel', 12.99, 3, 3);

INSERT INTO favorites (user_id, product_id) VALUES (1, 1), (1, 2), (2, 1);

-- Queries
SELECT * FROM products WHERE category_id = 1;
SELECT * FROM products WHERE brand_id = 2;
SELECT product_id, COUNT(*) as fav_count FROM favorites GROUP BY product_id ORDER BY fav_count DESC;
