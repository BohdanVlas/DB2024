-- Active: 1714217594175@@127.0.0.1@3300@library

-- Процедури
CREATE OR REPLACE PROCEDURE loan_book(
    IN p_user_id INT,
    IN p_book_id INT,
    IN p_date_issued DATE,
    IN p_date_due DATE
)
AS $$
BEGIN
    INSERT INTO loans (book_id, user_id, date_issued, date_due)
    VALUES (p_book_id, p_user_id, p_date_issued, p_date_due);

    UPDATE copies
    SET availability = 'вибрано'
    WHERE book_id = p_book_id
    AND copy_id IN (
        SELECT copy_id
        FROM copies
        WHERE book_id = p_book_id
        AND availability = 'доступний'
        LIMIT 1
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE return_book(
    IN p_loan_id INT,
    IN p_date_returned DATE
)
AS $$
BEGIN
    UPDATE loans
    SET date_returned = p_date_returned
    WHERE loan_id = p_loan_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE delete_user(
    IN p_user_id INT
)
AS $$
BEGIN
    DELETE FROM users
    WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;

CALL loan_book(1, 2, '2024-05-20', '2024-06-03');
CALL return_book(11, '2024-06-03');
CALL delete_user(5);


-- Функції
CREATE OR REPLACE FUNCTION count_available_copies(p_book_id INT)
RETURNS INT AS $$
DECLARE
    available_copies INT;
BEGIN
    SELECT COUNT(*)
    INTO available_copies
    FROM copies
    WHERE book_id = p_book_id
    AND availability = 'доступний';

    RETURN available_copies;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_author_name(p_book_id INT)
RETURNS VARCHAR AS $$
DECLARE
    author_name VARCHAR;
BEGIN
    SELECT authors.author_name
    INTO author_name
    FROM authors
    JOIN books ON authors.author_id = books.author_id
    WHERE books.book_id = p_book_id;

    RETURN author_name;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_book_available(p_book_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    available BOOLEAN;
BEGIN
    SELECT COUNT(*)
    INTO available
    FROM copies
    WHERE book_id = p_book_id
    AND availability = 'доступний';

    RETURN available;
END;
$$ LANGUAGE plpgsql;

SELECT count_available_copies(1);
SELECT get_author_name(1);
SELECT is_book_available(1);


-- Тригери
CREATE OR REPLACE FUNCTION update_availability()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.date_returned IS NULL AND NEW.date_returned IS NOT NULL THEN
        UPDATE copies
        SET availability = 'доступний'
        WHERE book_id = OLD.book_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_return
AFTER UPDATE OF date_returned ON loans
FOR EACH ROW
EXECUTE FUNCTION update_availability();

CREATE OR REPLACE FUNCTION delete_related_loans()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM loans
    WHERE book_id = OLD.book_id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_book_delete
AFTER DELETE ON books
FOR EACH ROW
EXECUTE FUNCTION delete_related_loans();

CREATE OR REPLACE FUNCTION update_book_rating()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE books
    SET rating = NEW.rating
    WHERE book_id = NEW.book_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_rating_update
AFTER UPDATE OF rating ON books
FOR EACH ROW
EXECUTE FUNCTION update_book_rating();


-- Транзакції
BEGIN;
CALL loan_book(1, 2, '2024-05-20', '2024-06-03');
COMMIT;

BEGIN;
CALL delete_user(5);
COMMIT;



CALL loan_book(1, 12, '2024-05-20', '2024-06-03');

CALL return_book(11, '2024-06-03');

CALL delete_user(5);

SELECT count_available_copies(1);

SELECT get_author_name(1);

SELECT is_book_available(1);

UPDATE loans SET date_returned = '2024-06-03' WHERE loan_id = 11;

DELETE FROM books WHERE book_id = 3;

UPDATE books SET rating = 5 WHERE book_id = 4;
