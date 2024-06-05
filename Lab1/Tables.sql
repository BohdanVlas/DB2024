-- Active: 1714217594175@@127.0.0.1@3300@library
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR,
    password VARCHAR,
    name VARCHAR,
    contact_info VARCHAR
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR,
    author_id INT REFERENCES authors(author_id),
    genre_id INT REFERENCES genres(genre_id),
    rating FLOAT,
    year_published INT
);

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id),
    user_id INT REFERENCES users(user_id),
    date_issued DATE,
    date_due DATE,
    date_returned DATE
);

CREATE TABLE copies (
    copy_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id),
    availability VARCHAR
);

INSERT INTO authors (author_name) VALUES
('Джордж Оруелл'),
('Джейн Остін'),
('Філіп К. Дік'),
('Дж. Р. Р. Толкін'),
('Вільям Шекспір');

INSERT INTO genres (genre_name) VALUES
('Дистопія'),
('Роман'),
('Фентезі'),
('Трагедія'),
('Детектив'),
('Пригоди'),
('Історичний'),
('Поезія'),
('Наукова');

INSERT INTO books (title, author_id, genre_id, rating, year_published) VALUES
('1984', 1, 1, 4.5, 1949),
('Поневіра (Стародавній Рим)', 2, 2, 4.8, 1813),
('Мертві душі', 3, 2, 4.2, 1842),
('Володар перснів', 4, 3, 4.9, 1954),
('Ромео і Джульєтта', 5, 4, 4.7, 1597);

INSERT INTO users (username, password, name, contact_info) VALUES
('user1', 'pass1', 'Іван Петров', 'ivan@example.com'),
('user2', 'pass2', 'Олена Іванова', 'olena@example.com'),
('user3', 'pass3', 'Петро Сидоров', 'petro@example.com'),
('admin', 'adminpass', 'Адміністратор', 'admin@example.com');

INSERT INTO copies (book_id, availability) VALUES
(1, 'доступний'),
(1, 'доступний'),
(2, 'доступний'),
(3, 'вибрано'),
(4, 'доступний');

INSERT INTO loans (book_id, user_id, date_issued, date_due, date_returned) VALUES
(1, 1, '2024-04-01', '2024-04-15', NULL),
(2, 2, '2024-04-05', '2024-04-19', NULL),
(3, 3, '2024-04-10', '2024-04-24', NULL);

SELECT * FROM books;
