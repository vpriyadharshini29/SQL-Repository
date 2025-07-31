-- Create database
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Books table
CREATE TABLE books (
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  author VARCHAR(100),
  total_copies INT DEFAULT 1
);

-- Members table
CREATE TABLE members (
  member_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  join_date DATE
);

-- Borrowings table
CREATE TABLE borrowings (
  borrowing_id INT PRIMARY KEY AUTO_INCREMENT,
  book_id INT,
  member_id INT,
  borrow_date DATE,
  due_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Insert data
INSERT INTO members (name, email, join_date) VALUES
('Alice', 'alice@example.com', '2023-01-10'),
('Bob', 'bob@example.com', '2023-02-15'),
('Charlie', 'charlie@example.com', '2023-03-01'),
('Diana', 'diana@example.com', '2023-04-01'),
('Eve', 'eve@example.com', '2023-04-10'),
('Frank', 'frank@example.com', '2023-04-20'),
('Grace', 'grace@example.com', '2023-05-01'),
('Heidi', 'heidi@example.com', '2023-06-01'),
('Ivan', 'ivan@example.com', '2023-06-15'),
('Judy', 'judy@example.com', '2023-07-01');

INSERT INTO books (title, author, total_copies) VALUES
('1984', 'George Orwell', 5),
('To Kill a Mockingbird', 'Harper Lee', 3),
('The Great Gatsby', 'F. Scott Fitzgerald', 4),
('The Catcher in the Rye', 'J.D. Salinger', 3),
('Pride and Prejudice', 'Jane Austen', 6),
('Moby Dick', 'Herman Melville', 2),
('War and Peace', 'Leo Tolstoy', 3),
('Ulysses', 'James Joyce', 2),
('The Odyssey', 'Homer', 4),
('Hamlet', 'William Shakespeare', 5);

INSERT INTO borrowings (book_id, member_id, borrow_date, due_date) VALUES
(1, 2, '2025-07-01', '2025-07-15'),
(3, 2, '2025-07-02', '2025-07-16'),
(5, 1, '2025-07-03', '2025-07-17'),
(2, 3, '2025-06-25', '2025-07-05'),
(7, 4, '2025-07-04', '2025-07-20');

-- SELECT: Books borrowed by a member (Bob)
SELECT b.title
FROM books b
JOIN borrowings br ON b.book_id = br.book_id
JOIN members m ON br.member_id = m.member_id
WHERE m.name = 'Bob';

-- SELECT: Overdue books (assuming today is '2025-07-30')
SELECT m.name, b.title, br.due_date
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
JOIN members m ON br.member_id = m.member_id
WHERE br.due_date < '2025-07-30';

-- SELECT: Most borrowed books
SELECT b.title, COUNT(*) AS borrow_count
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.book_id
ORDER BY borrow_count DESC;
