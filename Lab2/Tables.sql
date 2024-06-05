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
('Вільям Шекспір'),
('Ернест Хемінгуей'),
('Агата Крісті'),
('Френсіс Скотт Фіцджеральд'),
('Марк Твен'),
('Чарльз Діккенс'),
('Тоні Моррісон'),
('Харпер Лі'),
('Джеймс Болдуїн'),
('Вірджинія Вульф'),
('Лео Толстой'),
('Джон Стейнбек'),
('Емілі Дікінсон'),
('Френк Герберт'),
('Достоєвський'),
('Тоні Моррісон');

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
('Ромео і Джульєтта', 5, 4, 4.7, 1597),
('По ком звонить дзвін', 6, 2, 4.6, 1940),
('Вбивство у Востеросі', 7, 5, 4.9, 1926),
('Великий Гетсбі', 8, 2, 4.7, 1925),
('Пригоди Гекльберрі Фінна', 9, 6, 4.5, 1884),
('Олівер Твіст', 10, 2, 4.3, 1838),
('Дорога', 11, 2, 4.8, 1997),
('Убити пересмішника', 12, 2, 4.9, 1960),
('Чорна красуня', 13, 2, 4.4, 1953),
('Місіс Деллоуей', 14, 2, 4.6, 1925),
('Війна і мир', 15, 7, 4.9, 1869),
('Мишка', 16, 2, 4.2, 1937),
('Поеми', 5, 8, 4.8, 1609),
('Пісні', 5, 8, 4.7, 1609),
('Герберт Свит', 18, 9, 4.6, 1965),
('Брати Карамазови', 19, 2, 4.9, 1880);


INSERT INTO users (username, password, name, contact_info) VALUES
('user1', 'pass1', 'Іван Петров', 'ivan@example.com'),
('user2', 'pass2', 'Олена Іванова', 'olena@example.com'),
('user3', 'pass3', 'Петро Сидоров', 'petro@example.com'),
('admin', 'adminpass', 'Адміністратор', 'admin@example.com'),
('user5', 'pass5', 'Марина Коваленко', 'marina@example.com'),
('user6', 'pass6', 'Ігор Лисенко', 'igor@example.com'),
('user7', 'pass7', 'Анна Семенова', 'anna@example.com'),
('user8', 'pass8', 'Михайло Кравчук', 'mikhailo@example.com'),
('user9', 'pass9', 'Олександра Левченко', 'oleksandra@example.com'),
('user10', 'pass10', 'Артем Сорокін', 'artem@example.com'),
('user11', 'pass11', 'Вікторія Жукова', 'viktoria@example.com'),
('user12', 'pass12', 'Євген Поляков', 'yevgen@example.com'),
('user13', 'pass13', 'Світлана Грищук', 'svitlana@example.com'),
('user14', 'pass14', 'Денис Козлов', 'denis@example.com'),
('user15', 'pass15', 'Наталія Морозова', 'natalia@example.com');

INSERT INTO copies (book_id, availability) VALUES
(1, 'доступний'),
(1, 'доступний'),
(2, 'доступний'),
(3, 'вибрано'),
(4, 'доступний'),
(6, 'доступний'),
(7, 'вибрано'),
(8, 'доступний'),
(9, 'доступний'),
(10, 'доступний'),
(11, 'доступний'),
(12, 'вибрано'),
(13, 'доступний'),
(14, 'доступний'),
(15, 'доступний'),
(16, 'доступний'),
(17, 'доступний'),
(18, 'доступний'),
(19, 'вибрано'),
(20, 'доступний');

INSERT INTO loans (book_id, user_id, date_issued, date_due, date_returned) VALUES
(1, 1, '2024-04-01', '2024-04-15', NULL),
(2, 2, '2024-04-05', '2024-04-19', NULL),
(3, 3, '2024-04-10', '2024-04-24', NULL),
(4, 4, '2024-04-15', '2024-04-29', NULL),
(5, 5, '2024-04-20', '2024-05-04', NULL),
(6, 6, '2024-04-25', '2024-05-09', NULL),
(7, 7, '2024-05-01', '2024-05-15', NULL),
(8, 8, '2024-05-05', '2024-05-19', NULL),
(9, 9, '2024-05-10', '2024-05-24', NULL),
(10, 10, '2024-05-15', '2024-05-29', NULL),
(11, 11, '2024-05-20', '2024-06-03', NULL),
(12, 12, '2024-05-25', '2024-06-08', NULL),
(13, 13, '2024-05-30', '2024-06-13', NULL),
(14, 14, '2024-06-05', '2024-06-19', NULL),
(15, 15, '2024-06-10', '2024-06-24', NULL);