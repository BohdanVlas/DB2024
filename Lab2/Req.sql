-- Active: 1714217594175@@127.0.0.1@3300@library

#Показати всі книги, які мають копії, але ні одна копія не доступна
SELECT books.* 
FROM books 
LEFT JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > 0 AND COUNT(CASE WHEN copies.availability = 'доступний' THEN 1 END) = 0;

#Показати всі книги, які мають кількість видач, що більше ніж кількість копій, та вибрати їх загальну кількість видач та рейтинг
SELECT books.*, COUNT(loans.loan_id) AS loan_count, SUM(books.rating) AS total_rating 
FROM books 
JOIN loans ON books.book_id = loans.book_id 
LEFT JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > COUNT(copies.copy_id);

#Показати всі книги, які були видані пізніше за 2024-05-01, та кількість видач, що більше за 2
SELECT books.*, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE loans.date_issued > '2024-05-01' 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > 2;

#Показати всі книги, які мають копії, та вибрати їх кількість копій та кількість видач
SELECT books.*, COUNT(copies.copy_id) AS copy_count, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id;

#Показати всі книги, які мають копії, та вибрати їх кількість копій та кількість видач, де кожна копія була вибрана
SELECT books.*, COUNT(copies.copy_id) AS copy_count, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
WHERE copies.availability = 'вибрано' 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) = COUNT(copies.copy_id);

#Показати всі книги, які мають копії, та вибрати їх кількість копій та рейтинг
SELECT books.*, COUNT(copies.copy_id) AS copy_count, books.rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id;

#Показати всі книги, які були видані у травні 2024 року, та загальний рейтинг менше за 4.5
SELECT books.*, SUM(books.rating) AS total_rating 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE EXTRACT(MONTH FROM loans.date_issued) = 5 AND EXTRACT(YEAR FROM loans.date_issued) = 2024 
GROUP BY books.book_id 
HAVING SUM(books.rating) < 4.5;

#Показати всі книги, які мають кількість копій, що більше ніж кількість видач, та вибрати їх загальну кількість копій та кількість видач
SELECT books.*, COUNT(copies.copy_id) AS copy_count, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > COUNT(loans.loan_id);

#Показати всі книги, які мають кількість копій більше ніж середня кількість копій для всіх книг у кожному жанрі, та вибрати їх загальну кількість копій та жанр
SELECT books.*, genres.genre_name, COUNT(copies.copy_id) AS copy_count 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN genres ON books.genre_id = genres.genre_id 
GROUP BY books.book_id, genres.genre_name 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count);

#Показати всі книги, які були видані у 2024 році, та загальний рейтинг більше або рівний 4.5
SELECT books.*, SUM(books.rating) AS total_rating 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE EXTRACT(YEAR FROM loans.date_issued) = 2024 
GROUP BY books.book_id 
HAVING SUM(books.rating) >= 4.5;

#Показати всі книги, які мають копії, та вибрати їх кількість копій та доступність
SELECT books.*, COUNT(copies.copy_id) AS copy_count, copies.availability 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id, copies.availability;

#Показати всі книги, які мають копії, та вибрати їх кількість копій та загальний рейтинг
SELECT books.*, COUNT(copies.copy_id) AS copy_count, SUM(books.rating) AS total_rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id;

#Показати всі книги, які мають копії, та вибрати їх кількість копій та доступність кожної книги
SELECT books.*, COUNT(copies.copy_id) AS copy_count, copies.availability 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id, copies.availability;

#Показати всі книги, які мають кількість копій більше ніж середня кількість копій для всіх книг, та вибрати їх загальну кількість копій та рейтинг
SELECT books.*, COUNT(copies.copy_id) AS copy_count, SUM(books.rating) AS total_rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > (SELECT AVG(copy_count) FROM (SELECT COUNT(copy_id) AS copy_count FROM copies GROUP BY book_id) AS avg_copy_count);

#Показати всі книги, які мають кількість видач, що більше за кількість копій, та вибрати їх загальну кількість видач та доступність
SELECT books.*, COUNT(loans.loan_id) AS loan_count, copies.availability 
FROM books JOIN copies ON books.book_id = copies.book_id 
JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id, copies.availability 
HAVING COUNT(loans.loan_id) > COUNT(copies.copy_id);

#Показати всі книги, які були видані у травні 2024 року, та кількість видач, що більше за 2
SELECT books.*, COUNT(loans.loan_id) AS loan_count 
FROM books JOIN loans ON books.book_id = loans.book_id 
WHERE EXTRACT(MONTH FROM loans.date_issued) = 5 AND EXTRACT(YEAR FROM loans.date_issued) = 2024 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > 2;

#Показати всі книги, які мають копії, та вибрати їх кількість копій та рейтинг, де кожна копія доступна
SELECT books.*, COUNT(copies.copy_id) AS copy_count, books.rating 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) = COUNT(CASE WHEN copies.availability = 'доступний' THEN 1 END);

#Показати всі книги, які мають копії, але ні одна копія не вибрана
SELECT books.* 
FROM books 
LEFT JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id 
HAVING COUNT(copies.copy_id) > 0 AND COUNT(CASE WHEN copies.availability = 'вибрано' THEN 1 END) = 0;

#Показати всі книги, які мають кількість видач, що більше ніж середня кількість видач для всіх книг, та загальний рейтинг більше або рівний 4.5
SELECT books.*, COUNT(loans.loan_id) AS loan_count, SUM(books.rating) AS total_rating 
FROM books JOIN loans ON books.book_id = loans.book_id 
GROUP BY books.book_id 
HAVING COUNT(loans.loan_id) > (SELECT AVG(loan_count) FROM (SELECT COUNT(loan_id) AS loan_count FROM loans GROUP BY book_id) AS avg_loan_count) 
AND SUM(books.rating) >= 4.5;

#Показати всі книги, які мають копії, та вибрати їх кількість копій, рейтинг та доступність, де загальна кількість копій менше або рівна 2
SELECT books.*, COUNT(copies.copy_id) AS copy_count, books.rating, copies.availability 
FROM books JOIN copies ON books.book_id = copies.book_id 
GROUP BY books.book_id, books.rating, copies.availability 
HAVING COUNT(copies.copy_id) <= 2;
