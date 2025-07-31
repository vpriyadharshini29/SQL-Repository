-- Count books issued per member
SELECT m.first_name, COUNT(c.checkout_id) AS book_count
FROM members m
INNER JOIN checkouts c ON m.member_id = c.member_id
GROUP BY m.first_name;

-- Members with fines over ₹500
SELECT m.first_name, SUM(f.amount) AS total_fines
FROM members m
INNER JOIN fines f ON m.member_id = f.member_id
GROUP BY m.first_name
HAVING SUM(f.amount) > 500;

-- Books with > 5 checkouts
SELECT b.title, COUNT(c.checkout_id) AS checkout_count
FROM books b
INNER JOIN checkouts c ON b.book_id = c.book_id
GROUP BY b.title
HAVING COUNT(c.checkout_id) > 5;

-- INNER JOIN checkouts, members, books
SELECT m.first_name, b.title, c.checkout_date
FROM members m
INNER JOIN checkouts c ON m.member_id = c.member_id
INNER JOIN books b ON c.book_id = b.book_id;

-- LEFT JOIN books and checkouts
SELECT b.title, c.checkout_id
FROM books b
LEFT JOIN checkouts c ON b.book_id = c.book_id;

-- SELF JOIN members who borrowed same books
SELECT m1.first_name AS member1, m2.first_name AS member2, b.title
FROM checkouts c1
INNER JOIN checkouts c2 ON c1.book_id = c2.book_id AND c1.member_id < c2.member_id
INNER JOIN members m1 ON c1.member_id = m1.member_id
INNER JOIN members m2 ON c2.member_id = m2.member_id
INNER JOIN books b ON c1.book_id = b.book_id;