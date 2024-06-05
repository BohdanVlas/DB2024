-- Active: 1714217594175@@127.0.0.1@3300@library

CREATE USER librarian WITH PASSWORD 'librarianpass';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO librarian;

CREATE USER member WITH PASSWORD 'memberpass';
GRANT SELECT, INSERT, UPDATE ON books, loans, copies TO member;

CREATE USER guest WITH PASSWORD 'guestpass';
GRANT SELECT ON books, copies TO guest;