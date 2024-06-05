-- Active: 1714217594175@@127.0.0.1@3300@library

CREATE OR REPLACE FUNCTION create_author(
    author_name VARCHAR
) RETURNS INTEGER AS $$
BEGIN
    INSERT INTO authors (author_name) VALUES (author_name);
    RETURN (SELECT currval('authors_author_id_seq'));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_author(
    p_author_id INT,
    p_author_name VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE authors 
    SET author_name = p_author_name 
    WHERE author_id = p_author_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_author(
    p_author_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM authors WHERE author_id = p_author_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_all_authors() RETURNS SETOF authors AS $$
BEGIN
    RETURN QUERY SELECT * FROM authors;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_author_by_id(
    author_id INT
) RETURNS authors AS $$
BEGIN
    RETURN QUERY SELECT * FROM authors WHERE author_id = author_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_user(
    username VARCHAR,
    password VARCHAR,
    name VARCHAR,
    contact_info VARCHAR
) RETURNS INTEGER AS $$
BEGIN
    INSERT INTO users (username, password, name, contact_info) VALUES (username, password, name, contact_info);
    RETURN (SELECT currval('users_user_id_seq'));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_user(
    p_user_id INT,
    p_username VARCHAR,
    p_password VARCHAR,
    p_name VARCHAR,
    p_contact_info VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE users 
    SET username = p_username,
        password = p_password,
        name = p_name,
        contact_info = p_contact_info 
    WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_user(
    p_user_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM users WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_all_users() RETURNS SETOF users AS $$
BEGIN
    RETURN QUERY SELECT * FROM users;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_user_by_id(
    user_id INT
) RETURNS users AS $$
BEGIN
    RETURN QUERY SELECT * FROM users WHERE user_id = user_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_book(
    title VARCHAR,
    author_id INT,
    genre_id INT,
    rating FLOAT,
    year_published INT
) RETURNS INTEGER AS $$
BEGIN
    INSERT INTO books (title, author_id, genre_id, rating, year_published) VALUES (title, author_id, genre_id, rating, year_published);
    RETURN (SELECT currval('books_book_id_seq'));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_book(
    p_book_id INT,
    p_title VARCHAR,
    p_author_id INT,
    p_genre_id INT,
    p_rating FLOAT,
    p_year_published INT
) RETURNS VOID AS $$
BEGIN
    UPDATE books 
    SET title = p_title, 
        author_id = p_author_id, 
        genre_id = p_genre_id, 
        rating = p_rating, 
        year_published = p_year_published 
    WHERE book_id = p_book_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_book(
    p_book_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM loans WHERE book_id = p_book_id;
    DELETE FROM copies WHERE book_id = p_book_id;
    DELETE FROM books WHERE book_id = p_book_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_all_books() RETURNS SETOF books AS $$
BEGIN
    RETURN QUERY SELECT * FROM books;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_book_by_id(
    p_book_id INT
) RETURNS books AS $$
DECLARE
    book_record books%ROWTYPE;
BEGIN
    SELECT * INTO book_record FROM books WHERE book_id = p_book_id;
    RETURN book_record;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS get_book_by_id(INT);



CREATE OR REPLACE FUNCTION create_loan(
    book_id INT,
    user_id INT,
    date_issued DATE,
    date_due DATE,
    date_returned DATE
) RETURNS INTEGER AS $$
BEGIN
    INSERT INTO loans (book_id, user_id, date_issued, date_due, date_returned) VALUES (book_id, user_id, date_issued, date_due, date_returned);
    RETURN (SELECT currval('loans_loan_id_seq'));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_loan(
    p_loan_id INT,
    p_book_id INT,
    p_user_id INT,
    p_date_issued DATE,
    p_date_due DATE,
    p_date_returned DATE
) RETURNS VOID AS $$
BEGIN
    UPDATE loans 
    SET book_id = p_book_id,
        user_id = p_user_id,
        date_issued = p_date_issued,
        date_due = p_date_due,
        date_returned = p_date_returned
    WHERE loan_id = p_loan_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_loan(
    p_loan_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM loans WHERE loan_id = p_loan_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_all_loans() RETURNS SETOF loans AS $$
BEGIN
    RETURN QUERY SELECT * FROM loans;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_loan_by_id(
    loan_id INT
) RETURNS loans AS $$
BEGIN
    RETURN QUERY SELECT * FROM loans WHERE loan_id = loan_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_copy(
    book_id INT,
    availability VARCHAR
) RETURNS INTEGER AS $$
BEGIN
    INSERT INTO copies (book_id, availability) VALUES (book_id, availability);
    RETURN (SELECT currval('copies_copy_id_seq'));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_copy(
    p_copy_id INT,
    p_book_id INT,
    p_availability VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE copies 
    SET book_id = p_book_id,
        availability = p_availability
    WHERE copy_id = p_copy_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_copy(
    p_copy_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM copies WHERE copy_id = p_copy_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_all_copies() RETURNS SETOF copies AS $$
BEGIN
    RETURN QUERY SELECT * FROM copies;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_copy_by_id(
    copy_id INT
) RETURNS copies AS $$
BEGIN
    RETURN QUERY SELECT * FROM copies WHERE copy_id = copy_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_genre(
    p_genre_name VARCHAR
) RETURNS INTEGER AS $$
BEGIN
    INSERT INTO genres (genre_name) VALUES (p_genre_name);
    RETURN (SELECT currval('genres_genre_id_seq'));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_genre(
    p_genre_id INT,
    p_genre_name VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE genres 
    SET genre_name = p_genre_name 
    WHERE genre_id = p_genre_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_genre(
    p_genre_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM genres WHERE genre_id = p_genre_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_genre_by_id(
    p_genre_id INT
) RETURNS genres AS $$
BEGIN
    RETURN QUERY SELECT * FROM genres WHERE genre_id = p_genre_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_all_genres() RETURNS SETOF genres AS $$
BEGIN
    RETURN QUERY SELECT * FROM genres;
END;
$$ LANGUAGE plpgsql;



SELECT create_book('Нова книга', 1, 1, 4.0, 2024);

SELECT update_book(27, 'Оновлена книга', 2, 2, 4.5, 2023);

SELECT delete_book(27);

SELECT * FROM get_book_by_id(27);

SELECT * FROM get_all_books();