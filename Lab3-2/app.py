from flask import Flask, request, jsonify
import psycopg2

app = Flask(__name__)

db_params = {
    'dbname': 'library',
    'user': 'postgres',
    'password': 'white3',
    'host': 'localhost',
    'port': '3300'
}

def execute_query(query, values=None):
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    if values:
        cursor.execute(query, values)
    else:
        cursor.execute(query)
    if cursor.description:
        result = cursor.fetchall()
    else:
        result = None
    connection.commit()
    cursor.close()
    connection.close()
    return result



# Операції з авторами
@app.route('/authors', methods=['GET'])
def get_authors():
    query = "SELECT * FROM authors"
    authors = execute_query(query)
    return jsonify(authors)

@app.route('/authors', methods=['POST'])
def create_author():
    data = request.json
    author_name = data['author_name']
    query = "INSERT INTO authors (author_name) VALUES (%s) RETURNING author_id"
    result = execute_query(query, (author_name,))
    author_id = result[0][0]
    return jsonify({'author_id': author_id}), 201

@app.route('/authors/<int:author_id>', methods=['PUT'])
def update_author(author_id):
    data = request.json
    author_name = data['author_name']
    query = "UPDATE authors SET author_name = %s WHERE author_id = %s"
    execute_query(query, (author_name, author_id))
    return jsonify({'message': 'Author updated successfully'}), 200

@app.route('/authors/<int:author_id>', methods=['DELETE'])
def delete_author(author_id):
    query = "DELETE FROM books WHERE author_id = %s"
    execute_query(query, (author_id,))
    query = "DELETE FROM authors WHERE author_id = %s"
    execute_query(query, (author_id,))
    return jsonify({'message': 'Author and related records deleted successfully'}), 200


# Операції з користувачами
@app.route('/users', methods=['GET'])
def get_users():
    query = "SELECT * FROM users"
    users = execute_query(query)
    return jsonify(users)

@app.route('/users', methods=['POST'])
def create_user():
    data = request.json
    username = data['username']
    password = data['password']
    name = data['name']
    contact_info = data['contact_info']
    query = "INSERT INTO users (username, password, name, contact_info) VALUES (%s, %s, %s, %s) RETURNING user_id"
    result = execute_query(query, (username, password, name, contact_info))
    user_id = result[0][0]
    return jsonify({'user_id': user_id}), 201

@app.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    data = request.json
    username = data['username']
    password = data['password']
    name = data['name']
    contact_info = data['contact_info']
    query = "UPDATE users SET username = %s, password = %s, name = %s, contact_info = %s WHERE user_id = %s"
    execute_query(query, (username, password, name, contact_info, user_id))
    return jsonify({'message': 'User updated successfully'}), 200

@app.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    query = "DELETE FROM users WHERE user_id = %s"
    execute_query(query, (user_id,))
    return jsonify({'message': 'User deleted successfully'}), 200


# Операції з книгами
@app.route('/books', methods=['GET'])
def get_books():
    query = "SELECT b.book_id, b.title, a.author_name, g.genre_name, b.rating, b.year_published FROM books b JOIN authors a ON b.author_id = a.author_id JOIN genres g ON b.genre_id = g.genre_id"
    books = execute_query(query)
    return jsonify(books)

@app.route('/books', methods=['POST'])
def create_book():
    data = request.json
    title = data['title']
    author_id = data['author_id']
    genre_id = data['genre_id']
    rating = data['rating']
    year_published = data['year_published']
    query = "INSERT INTO books (title, author_id, genre_id, rating, year_published) VALUES (%s, %s, %s, %s, %s) RETURNING book_id"
    result = execute_query(query, (title, author_id, genre_id, rating, year_published))
    book_id = result[0][0]
    return jsonify({'book_id': book_id}), 201

@app.route('/books/<int:book_id>', methods=['PUT'])
def update_book(book_id):
    data = request.json
    title = data['title']
    author_id = data['author_id']
    genre_id = data['genre_id']
    rating = data['rating']
    year_published = data['year_published']
    query = "UPDATE books SET title = %s, author_id = %s, genre_id = %s, rating = %s, year_published = %s WHERE book_id = %s"
    execute_query(query, (title, author_id, genre_id, rating, year_published, book_id))
    return jsonify({'message': 'Book updated successfully'}), 200

@app.route('/books/<int:book_id>', methods=['DELETE'])
def delete_book(book_id):
    query = "DELETE FROM copies WHERE book_id = %s"
    execute_query(query, (book_id,))
    query = "DELETE FROM loans WHERE book_id = %s"
    execute_query(query, (book_id,))
    query = "DELETE FROM books WHERE book_id = %s"
    execute_query(query, (book_id,))
    return jsonify({'message': 'Book and related records deleted successfully'}), 200


# Операції з копіями
@app.route('/copies', methods=['GET'])
def get_copies():
    query = "SELECT * FROM copies"
    copies = execute_query(query)
    return jsonify(copies)

@app.route('/copies', methods=['POST'])
def create_copy():
    data = request.json
    book_id = data['book_id']
    availability = data['availability']
    query = "INSERT INTO copies (book_id, availability) VALUES (%s, %s) RETURNING copy_id"
    result = execute_query(query, (book_id, availability))
    copy_id = result[0][0]
    return jsonify({'copy_id': copy_id}), 201

@app.route('/copies/<int:copy_id>', methods=['PUT'])
def update_copy(copy_id):
    data = request.json
    book_id = data['book_id']
    availability = data['availability']
    query = "UPDATE copies SET book_id = %s, availability = %s WHERE copy_id = %s"
    execute_query(query, (book_id, availability, copy_id))
    return jsonify({'message': 'Copy updated successfully'}), 200

@app.route('/copies/<int:copy_id>', methods=['DELETE'])
def delete_copy(copy_id):
    query = "DELETE FROM copies WHERE copy_id = %s"
    execute_query(query, (copy_id,))
    return jsonify({'message': 'Copy deleted successfully'}), 200


# Операції з видачами
@app.route('/loans', methods=['GET'])
def get_loans():
    query = "SELECT * FROM loans"
    loans = execute_query(query)
    return jsonify(loans)

@app.route('/loans', methods=['POST'])
def create_loan():
    data = request.json
    book_id = data['book_id']
    user_id = data['user_id']
    date_issued = data['date_issued']
    date_due = data['date_due']
    date_returned = data.get('date_returned', None)
    query = "INSERT INTO loans (book_id, user_id, date_issued, date_due, date_returned) VALUES (%s, %s, %s, %s, %s) RETURNING loan_id"
    result = execute_query(query, (book_id, user_id, date_issued, date_due, date_returned))
    loan_id = result[0][0]
    return jsonify({'loan_id': loan_id}), 201

@app.route('/loans/<int:loan_id>', methods=['PUT'])
def update_loan(loan_id):
    data = request.json
    book_id = data['book_id']
    user_id = data['user_id']
    date_issued = data['date_issued']
    date_due = data['date_due']
    date_returned = data.get('date_returned', None)
    query = "UPDATE loans SET book_id = %s, user_id = %s, date_issued = %s, date_due = %s, date_returned = %s WHERE loan_id = %s"
    execute_query(query, (book_id, user_id, date_issued, date_due, date_returned, loan_id))
    return jsonify({'message': 'Loan updated successfully'}), 200

@app.route('/loans/<int:loan_id>', methods=['DELETE'])
def delete_loan(loan_id):
    query = "DELETE FROM loans WHERE loan_id = %s"
    execute_query(query, (loan_id,))
    return jsonify({'message': 'Loan deleted successfully'}), 200


# Операції з жанрами
@app.route('/genres', methods=['GET'])
def get_genres():
    query = "SELECT * FROM genres"
    genres = execute_query(query)
    return jsonify(genres)

@app.route('/genres', methods=['POST'])
def create_genre():
    data = request.json
    genre_name = data['genre_name']
    query = "INSERT INTO genres (genre_name) VALUES (%s) RETURNING genre_id"
    result = execute_query(query, (genre_name,))
    genre_id = result[0][0]
    return jsonify({'genre_id': genre_id}), 201

@app.route('/genres/<int:genre_id>', methods=['PUT'])
def update_genre(genre_id):
    data = request.json
    genre_name = data['genre_name']
    query = "UPDATE genres SET genre_name = %s WHERE genre_id = %s"
    execute_query(query, (genre_name, genre_id))
    return jsonify({'message': 'Genre updated successfully'}), 200

@app.route('/genres/<int:genre_id>', methods=['DELETE'])
def delete_genre(genre_id):
    query = "DELETE FROM books WHERE genre_id = %s"
    execute_query(query, (genre_id,))
    query = "DELETE FROM genres WHERE genre_id = %s"
    execute_query(query, (genre_id,))
    return jsonify({'message': 'Genre and related records deleted successfully'}), 200


if __name__ == '__main__':
    app.run(debug=True)