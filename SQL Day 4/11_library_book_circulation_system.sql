-- Project 1: Library Book Circulation System

-- Subquery to find books borrowed more than average
SELECT book_id, COUNT(*) AS borrow_count
FROM loans
GROUP BY book_id
HAVING COUNT(*) > (SELECT AVG(borrow_count) FROM (SELECT COUNT(*) AS borrow_count FROM loans GROUP BY book_id) AS avg_borrow);

-- CASE to classify members based on total borrowings
SELECT member_id,
       COUNT(*) AS total_loans,
       CASE
           WHEN COUNT(*) > 20 THEN 'Frequent Reader'
           WHEN COUNT(*) BETWEEN 10 AND 20 THEN 'Moderate Reader'
           ELSE 'Occasional Reader'
       END AS member_type
FROM loans
GROUP BY member_id;

-- Most borrowed genres
SELECT b.genre, COUNT(*) AS borrow_count
FROM loans l
JOIN books b ON l.book_id = b.book_id
GROUP BY b.genre;

-- Active and inactive borrowers
SELECT member_id FROM loans
UNION
SELECT member_id FROM members WHERE member_id NOT IN (SELECT DISTINCT member_id FROM loans);

-- Members who borrowed both Fiction and Non-Fiction
SELECT member_id FROM loans l JOIN books b ON l.book_id = b.book_id WHERE b.genre = 'Fiction'
INTERSECT
SELECT member_id FROM loans l JOIN books b ON l.book_id = b.book_id WHERE b.genre = 'Non-Fiction';

-- Loans in the past 90 days
SELECT * FROM loans WHERE loan_date >= DATE('now', '-90 days');
