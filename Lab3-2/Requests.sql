-- Active: 1714217594175@@127.0.0.1@3300@library

SELECT * FROM books;

SELECT * FROM authors;

SELECT * FROM genres;

SELECT * FROM users;

SELECT * FROM books WHERE rating > 4.5;

SELECT * FROM books WHERE year_published < 1900;

SELECT * FROM books WHERE author_id IN (SELECT author_id FROM authors WHERE author_name = 'Джордж Оруелл');

SELECT * FROM books WHERE genre_id IN (SELECT genre_id FROM genres WHERE genre_name = 'Детектив');

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id;

SELECT books.* FROM books LEFT JOIN copies ON books.book_id = copies.book_id WHERE copies.copy_id IS NULL OR copies.availability = 'доступний';

SELECT * FROM users WHERE user_id IN (SELECT user_id FROM loans WHERE date_issued BETWEEN '2024-05-01' AND '2024-06-10');

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.user_id = 1 AND loans.date_issued BETWEEN '2024-04-01' AND '2024-04-15';

SELECT books.* FROM books LEFT JOIN copies ON books.book_id = copies.book_id WHERE copies.copy_id IS NULL;

SELECT books.* FROM books JOIN copies ON books.book_id = copies.book_id;

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.date_returned > loans.date_due;

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.date_returned IS NULL AND loans.date_due < CURRENT_DATE;

SELECT books.* FROM books LEFT JOIN loans ON books.book_id = loans.book_id WHERE loans.loan_id IS NULL;

SELECT * FROM books WHERE rating BETWEEN 4.0 AND 4.5;

SELECT genres.genre_name, COUNT(books.book_id) AS book_count FROM genres LEFT JOIN books ON genres.genre_id = books.genre_id GROUP BY genres.genre_name;

SELECT year_published, COUNT(book_id) AS book_count FROM books GROUP BY year_published;

SELECT users.name, COUNT(loans.book_id) AS books_taken FROM users JOIN loans ON users.user_id = loans.user_id GROUP BY users.name;

SELECT genres.genre_name, AVG(books.rating) AS average_rating FROM genres LEFT JOIN books ON genres.genre_id = books.genre_id GROUP BY genres.genre_name;

SELECT books.title, COUNT(copies.copy_id) AS copy_count FROM books LEFT JOIN copies ON books.book_id = copies.book_id GROUP BY books.title;

SELECT users.name, COUNT(loans.book_id) AS books_taken FROM users JOIN loans ON users.user_id = loans.user_id WHERE loans.date_returned IS NULL GROUP BY users.name;

SELECT EXTRACT(MONTH FROM date_issued) AS month, COUNT(book_id) AS books_taken FROM loans GROUP BY EXTRACT(MONTH FROM date_issued);

#25 

SELECT * FROM books WHERE book_id NOT IN (SELECT DISTINCT book_id FROM loans);

SELECT * FROM books WHERE rating > (SELECT AVG(rating) FROM books);

SELECT books.*, CURRENT_DATE - date_issued AS days_taken FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.date_returned IS NULL;

SELECT * FROM books WHERE book_id IN (SELECT book_id FROM copies GROUP BY book_id HAVING COUNT(copy_id) <= 2);

SELECT * FROM books WHERE rating = (SELECT MAX(rating) FROM books);

SELECT * FROM books WHERE rating = (SELECT MIN(rating) FROM books);

SELECT * FROM books WHERE book_id IN (SELECT book_id FROM copies GROUP BY book_id HAVING COUNT(copy_id) = (SELECT COUNT(copy_id) FROM copies GROUP BY book_id LIMIT 1));

SELECT * FROM books WHERE book_id IN (SELECT book_id FROM copies GROUP BY book_id HAVING COUNT(copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count));

SELECT books.*, COUNT(loans.loan_id) AS loan_count FROM books JOIN loans ON books.book_id = loans.book_id GROUP BY books.book_id HAVING COUNT(loans.loan_id) > 5;

SELECT * FROM books WHERE book_id NOT IN (SELECT DISTINCT book_id FROM loans);

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.date_issued > '2024-05-15';

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.user_id = 1 AND loans.date_returned IS NOT NULL;

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.user_id NOT IN (SELECT user_id FROM users) AND loans.date_returned IS NULL;

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id JOIN users ON loans.user_id = users.user_id WHERE users.username = 'admin';

SELECT * FROM books WHERE book_id NOT IN (SELECT DISTINCT book_id FROM loans WHERE date_returned IS NOT NULL);

SELECT books.* FROM books LEFT JOIN loans ON books.book_id = loans.book_id JOIN users ON loans.user_id = users.user_id WHERE users.username != 'admin' OR loans.user_id IS NULL;

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.user_id = 1 AND loans.date_returned IS NULL;

SELECT * FROM books WHERE book_id IN (SELECT book_id FROM copies GROUP BY book_id HAVING COUNT(copy_id) > 1);

SELECT * FROM books WHERE rating < (SELECT AVG(rating) FROM books);

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE EXTRACT(MONTH FROM date_issued) = 5 AND EXTRACT(YEAR FROM date_issued) = 2024;

SELECT books.* FROM books JOIN authors ON books.author_id = authors.author_id JOIN genres ON books.genre_id = genres.genre_id WHERE (books.author_id, books.genre_id) IN (SELECT author_id, genre_id FROM books GROUP BY author_id, genre_id HAVING COUNT(book_id) > 1);

SELECT * FROM books WHERE title IN (SELECT title FROM books GROUP BY title HAVING COUNT(book_id) > 1);

SELECT books.* FROM books JOIN loans ON books.book_id = loans.book_id WHERE loans.date_issued > MAKE_DATE(books.year_published, 1, 1);

SELECT * FROM books WHERE title LIKE 'П%';

SELECT * FROM books WHERE rating > 4.0 AND rating < 4.5;

#50

SELECT genres.genre_name, COUNT(books.book_id) AS book_count 
FROM genres LEFT JOIN books ON genres.genre_id = books.genre_id 
GROUP BY genres.genre_name 
ORDER BY book_count DESC;

SELECT books.title, COALESCE(COUNT(copies.copy_id), 0) AS copy_count 
FROM books LEFT JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.title;

SELECT books.*, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
ORDER BY copy_count DESC;

SELECT authors.author_name, COUNT(books.book_id) AS book_count 
FROM authors LEFT JOIN books ON authors.author_id = books.author_id 
GROUP BY authors.author_name 
ORDER BY book_count DESC;

SELECT users.name, COUNT(loans.book_id) AS books_taken 
FROM users LEFT JOIN loans ON users.user_id = loans.user_id 
GROUP BY users.name 
ORDER BY books_taken DESC;

SELECT books.title, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.title 
HAVING COUNT(books.title) > 1;

SELECT authors.author_name, COUNT(books.book_id) AS high_rating_books 
FROM authors JOIN books ON authors.author_id = books.author_id 
WHERE books.rating > 4.5 
GROUP BY authors.author_name 
HAVING COUNT(books.book_id) > 1;

SELECT books.title, COUNT(copies.copy_id) AS copy_count, AVG(copies.copy_id) AS avg_copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.title;

SELECT books.title, COUNT(copies.copy_id) AS total_copy_count, SUM(CASE WHEN copies.availability = 'доступний' THEN 1 ELSE 0 END) AS available_copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.title;

SELECT books.* 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > 1 AND COUNT(CASE WHEN copies.availability = 'доступний' THEN 1 END) > 0;

SELECT books.title, COUNT(copies.copy_id) AS copy_count, AVG(books.rating) AS avg_rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.title;

SELECT DISTINCT books.* 
FROM books JOIN loans ON books.book_id = loans.book_id;

SELECT books.* 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > 1 AND COUNT(CASE WHEN copies.availability = 'доступний' THEN 1 END) = COUNT(copies.copy_id);

SELECT books.* 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count);

SELECT books.* 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > 1 AND COUNT(copies.copy_id) <= 3;

SELECT books.*, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE EXTRACT(YEAR FROM loans.date_issued) = 2024 
GROUP BY books.book_id;

SELECT books.* 
FROM books JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.book_id) > 1;

SELECT DISTINCT books.* 
FROM books JOIN (SELECT rating, COUNT(*) AS rating_count FROM books GROUP BY rating HAVING COUNT(*) = 1) AS unique_ratings ON books.rating = unique_ratings.rating;

SELECT books.*, loans.date_issued 
FROM books JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id, loans.date_issued 
HAVING COUNT(loans.loan_id) = 1;

SELECT books.*, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > (SELECT AVG(loan_count) FROM (SELECT COUNT(loan_id) AS loan_count FROM loans GROUP BY book_id) AS avg_loan_count);

SELECT books.*, loans.date_issued, loans.date_returned 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE loans.date_issued = loans.date_returned;

SELECT books.* 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) = COUNT(CASE WHEN copies.availability = 'вибрано' THEN 1 END);

SELECT books.* 
FROM books JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id 
HAVING COUNT(DISTINCT loans.user_id) > 1;

SELECT books.*, COUNT(loans.loan_id) AS loan_count, SUM(books.rating) AS total_rating 
FROM books JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > (SELECT AVG(loan_count) FROM (SELECT COUNT(loan_id) AS loan_count FROM loans GROUP BY book_id) AS avg_loan_count);

SELECT books.*, copies.* 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
WHERE loans.date_returned IS NULL;

#75

SELECT books.*, genres.genre_name, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN genres ON books.genre_id = genres.genre_id 
GROUP BY books.book_id, genres.genre_name 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count);

SELECT books.*, loans.date_issued, loans.date_returned 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE EXTRACT(MONTH FROM loans.date_issued) = EXTRACT(MONTH FROM loans.date_returned);

SELECT books.*, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > 2 
ORDER BY copy_count DESC;

SELECT books.*, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count) 
AND books.rating <= 4.5;

SELECT books.*, loans.date_issued, loans.date_returned 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE loans.date_issued > '2024-05-15' AND loans.date_returned < '2024-06-01';

SELECT books.* 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING (COUNT(copies.copy_id) > 1 AND COUNT(CASE WHEN copies.availability != 'доступний' THEN 1 END) = 0) OR COUNT(copies.copy_id) = COUNT(CASE WHEN copies.availability = 'вибрано' THEN 1 END);

SELECT books.*, COUNT(loans.loan_id) AS loan_count, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > COUNT(copies.copy_id);

SELECT books.*, loans.date_issued, loans.date_returned 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE loans.date_issued = loans.date_returned 
ORDER BY loans.date_issued;

SELECT books.*, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id;

SELECT books.*, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count) 
AND COUNT(CASE WHEN copies.availability = 'доступний' THEN 1 END) = COUNT(copies.copy_id);

SELECT books.*, COUNT(copies.copy_id) AS copy_count, SUM(books.rating) AS total_rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count) 
AND SUM(books.rating) <= 4.5;

SELECT books.*, AVG(books.rating) AS avg_rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id;

SELECT books.*, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
WHERE EXTRACT(YEAR FROM loans.date_issued) = 2024 
GROUP BY books.book_id;

SELECT books.*, COUNT(loans.loan_id) AS loan_count, SUM(books.rating) AS total_rating 
FROM books 
JOIN loans ON books.book_id = loans.book_id 
LEFT JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > COUNT(copies.copy_id);

SELECT books.*, SUM(books.rating) AS total_rating 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE loans.date_issued > '2024-05-01' 
GROUP BY books.book_id 
HAVING SUM(books.rating) < 4.5;

SELECT books.*, COUNT(copies.copy_id) AS copy_count, books.rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id;

SELECT books.*, SUM(books.rating) AS total_rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING SUM(books.rating) < 4.5;

SELECT books.*, COUNT(copies.copy_id) AS copy_count, books.rating, copies.availability 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id, copies.availability;

SELECT books.*, COUNT(copies.copy_id) AS copy_count, SUM(CASE WHEN copies.availability = 'доступний' THEN 1 ELSE 0 END) AS available_copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count);

SELECT books.*, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE EXTRACT(MONTH FROM loans.date_issued) = 5 AND EXTRACT(YEAR FROM loans.date_issued) = 2024 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > 1;

SELECT books.*, COUNT(copies.copy_id) AS copy_count, SUM(books.rating) AS total_rating, copies.availability 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id, copies.availability;

SELECT books.*, COUNT(loans.loan_id) AS loan_count, SUM(CASE WHEN copies.availability = 'доступний' THEN 1 ELSE 0 END) AS available_copy_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > (SELECT AVG(loan_count) FROM (SELECT COUNT(loan_id) AS loan_count FROM loans GROUP BY book_id) AS avg_loan_count) 
AND SUM(CASE WHEN copies.availability = 'доступний' THEN 1 ELSE 0 END) > 1;

SELECT books.*, COUNT(copies.copy_id) AS copy_count, COUNT(loans.loan_id) AS loan_count, copies.availability 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id, copies.availability;

SELECT books.*, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE loans.date_issued = loans.date_returned 
GROUP BY books.book_id;

SELECT books.*, COUNT(loans.loan_id) AS loan_count, copies.availability 
FROM books JOIN loans ON books.book_id = loans.book_id 
JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id, copies.availability 
HAVING COUNT(loans.loan_id) > 2;