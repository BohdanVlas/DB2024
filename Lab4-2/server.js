const express = require('express');
const { MongoClient, ObjectId } = require('mongodb');

const app = express();
const port = 3000;

const url = 'mongodb://localhost:27017';
const dbName = 'library';

const client = new MongoClient(url);

app.use(express.json());

async function connectToDatabase() {
    try {
        await client.connect();
        console.log('Connected to the database');
    } catch (err) {
        console.error('Error connecting to the database:', err);
    }
}

connectToDatabase();


// Роут для отримання всіх авторів
app.get('/authors', async (req, res) => {
    try {
        const db = client.db(dbName);
        const authorsCollection = db.collection('authors');
        const authors = await authorsCollection.find({}).toArray();
        res.json(authors);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для створення нового автора
app.post('/authors', async (req, res) => {
    try {
        const { author_name } = req.body;
        if (!author_name) {
            return res.status(400).json({ message: 'Author name is required' });
        }
        const db = client.db(dbName);
        const authorsCollection = db.collection('authors');
        const result = await authorsCollection.insertOne({ author_name });
        res.json(result.ops[0]);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для отримання інформації про автора за ID
app.get('/authors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const authorsCollection = db.collection('authors');
        const author = await authorsCollection.findOne({ _id: new ObjectId(id) });
        if (author) {
            res.json(author);
        } else {
            res.status(404).json({ message: 'Author not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для оновлення інформації про автора за ID
app.put('/authors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { author_name } = req.body;
        if (!author_name) {
            return res.status(400).json({ message: 'Author name is required' });
        }
        const db = client.db(dbName);
        const authorsCollection = db.collection('authors');
        const result = await authorsCollection.updateOne({ _id: new ObjectId(id) }, { $set: { author_name } });
        if (result.modifiedCount === 1) {
            res.json({ message: 'Author updated successfully' });
        } else {
            res.status(404).json({ message: 'Author not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для видалення автора за ID
app.delete('/authors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const authorsCollection = db.collection('authors');
        const result = await authorsCollection.deleteOne({ _id: new ObjectId(id) });
        if (result.deletedCount === 1) {
            res.json({ message: 'Author deleted successfully' });
        } else {
            res.status(404).json({ message: 'Author not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});


// Роут для отримання всіх книг
app.get('/books', async (req, res) => {
    try {
        const db = client.db(dbName);
        const booksCollection = db.collection('books');
        const books = await booksCollection.find({}).toArray();
        res.json(books);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для створення нової книги
app.post('/books', async (req, res) => {
    try {
        const { title, author_id, genre_id, rating, year_published } = req.body;
        if (!title || !author_id || !genre_id || !rating || !year_published) {
            return res.status(400).json({ message: 'All fields are required' });
        }
        const db = client.db(dbName);
        const booksCollection = db.collection('books');
        const result = await booksCollection.insertOne({ title, author_id, genre_id, rating, year_published });
        res.json(result.ops[0]);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для отримання інформації про книгу за ID
app.get('/books/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const booksCollection = db.collection('books');
        const book = await booksCollection.findOne({ _id: parseInt(id) });
        if (book) {
            res.json(book);
        } else {
            res.status(404).json({ message: 'Book not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для оновлення інформації про книгу за ID
app.put('/books/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { title, author_id, genre_id, rating, year_published } = req.body;
        if (!title || !author_id || !genre_id || !rating || !year_published) {
            return res.status(400).json({ message: 'All fields are required' });
        }
        const db = client.db(dbName);
        const booksCollection = db.collection('books');
        const result = await booksCollection.updateOne({ _id: parseInt(id) }, { $set: { title, author_id, genre_id, rating, year_published } });
        if (result.modifiedCount === 1) {
            res.json({ message: 'Book updated successfully' });
        } else {
            res.status(404).json({ message: 'Book not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для видалення книги за ID
app.delete('/books/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const booksCollection = db.collection('books');
        const copiesCollection = db.collection('copies');
        const loansCollection = db.collection('loans');
        await copiesCollection.deleteMany({ book_id: parseInt(id) });
        await loansCollection.deleteMany({ book_id: parseInt(id) });
        const result = await booksCollection.deleteOne({ _id: parseInt(id) });
        if (result.deletedCount === 1) {
            res.json({ message: 'Book and related records deleted successfully' });
        } else {
            res.status(404).json({ message: 'Book not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});


// Роут для отримання всіх користувачів
app.get('/users', async (req, res) => {
    try {
        const db = client.db(dbName);
        const usersCollection = db.collection('users');
        const users = await usersCollection.find({}).toArray();
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для створення нового користувача
app.post('/users', async (req, res) => {
    try {
        const { username, password, name, contact_info } = req.body;
        if (!username || !password || !name || !contact_info) {
            return res.status(400).json({ message: 'All fields are required' });
        }
        const db = client.db(dbName);
        const usersCollection = db.collection('users');
        const result = await usersCollection.insertOne({ username, password, name, contact_info });
        res.json(result.ops[0]);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для отримання інформації про користувача за ID
app.get('/users/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const usersCollection = db.collection('users');
        const user = await usersCollection.findOne({ _id: new ObjectId(id) });
        if (user) {
            res.json(user);
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для оновлення інформації про користувача за ID
app.put('/users/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { username, password, name, contact_info } = req.body;
        if (!username || !password || !name || !contact_info) {
            return res.status(400).json({ message: 'All fields are required' });
        }
        const db = client.db(dbName);
        const usersCollection = db.collection('users');
        const result = await usersCollection.updateOne({ _id: new ObjectId(id) }, { $set: { username, password, name, contact_info } });
        if (result.modifiedCount === 1) {
            res.json({ message: 'User updated successfully' });
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для видалення користувача за ID
app.delete('/users/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const usersCollection = db.collection('users');
        const result = await usersCollection.deleteOne({ _id: new ObjectId(id) });
        if (result.deletedCount === 1) {
            res.json({ message: 'User deleted successfully' });
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});


// Роут для отримання всіх копій книг
app.get('/copies', async (req, res) => {
    try {
        const db = client.db(dbName);
        const copiesCollection = db.collection('copies');
        const copies = await copiesCollection.find({}).toArray();
        res.json(copies);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для створення нової копії книги
app.post('/copies', async (req, res) => {
    try {
        const { book_id, availability } = req.body;
        if (!book_id || availability === undefined) {
            return res.status(400).json({ message: 'Book ID and availability are required' });
        }
        const db = client.db(dbName);
        const copiesCollection = db.collection('copies');
        const result = await copiesCollection.insertOne({ book_id, availability });
        res.json(result.ops[0]);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для отримання інформації про копію книги за ID
app.get('/copies/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const copiesCollection = db.collection('copies');
        const copy = await copiesCollection.findOne({ _id: new ObjectId(id) });
        if (copy) {
            res.json(copy);
        } else {
            res.status(404).json({ message: 'Copy not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для оновлення інформації про копію книги за ID
app.put('/copies/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { book_id, availability } = req.body;
        if (!book_id || availability === undefined) {
            return res.status(400).json({ message: 'Book ID and availability are required' });
        }
        const db = client.db(dbName);
        const copiesCollection = db.collection('copies');
        const result = await copiesCollection.updateOne({ _id: new ObjectId(id) }, { $set: { book_id, availability } });
        if (result.modifiedCount === 1) {
            res.json({ message: 'Copy updated successfully' });
        } else {
            res.status(404).json({ message: 'Copy not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для видалення копії книги за ID
app.delete('/copies/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const copiesCollection = db.collection('copies');
        const result = await copiesCollection.deleteOne({ _id: new ObjectId(id) });
        if (result.deletedCount === 1) {
            res.json({ message: 'Copy deleted successfully' });
        } else {
            res.status(404).json({ message: 'Copy not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});


// Роут для отримання всіх позичок
app.get('/loans', async (req, res) => {
    try {
        const db = client.db(dbName);
        const loansCollection = db.collection('loans');
        const loans = await loansCollection.find({}).toArray();
        res.json(loans);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для створення нової позички
app.post('/loans', async (req, res) => {
    try {
        const { book_id, user_id, date_issued, date_due, date_returned } = req.body;
        if (!book_id || !user_id || !date_issued || !date_due) {
            return res.status(400).json({ message: 'Book ID, user ID, date issued, and date due are required' });
        }
        const db = client.db(dbName);
        const loansCollection = db.collection('loans');
        const result = await loansCollection.insertOne({ book_id, user_id, date_issued, date_due, date_returned });
        res.json(result.ops[0]);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для отримання інформації про позичку за ID
app.get('/loans/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const loansCollection = db.collection('loans');
        const loan = await loansCollection.findOne({ _id: new ObjectId(id) });
        if (loan) {
            res.json(loan);
        } else {
            res.status(404).json({ message: 'Loan not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для оновлення інформації про позичку за ID
app.put('/loans/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { book_id, user_id, date_issued, date_due, date_returned } = req.body;
        if (!book_id || !user_id || !date_issued || !date_due) {
            return res.status(400).json({ message: 'Book ID, user ID, date issued, and date due are required' });
        }
        const db = client.db(dbName);
        const loansCollection = db.collection('loans');
        const result = await loansCollection.updateOne({ _id: new ObjectId(id) }, { $set: { book_id, user_id, date_issued, date_due, date_returned } });
        if (result.modifiedCount === 1) {
            res.json({ message: 'Loan updated successfully' });
        } else {
            res.status(404).json({ message: 'Loan not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для видалення позички за ID
app.delete('/loans/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const loansCollection = db.collection('loans');
        const result = await loansCollection.deleteOne({ _id: new ObjectId(id) });
        if (result.deletedCount === 1) {
            res.json({ message: 'Loan deleted successfully' });
        } else {
            res.status(404).json({ message: 'Loan not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});


// Роут для отримання всіх жанрів
app.get('/genres', async (req, res) => {
    try {
        const db = client.db(dbName);
        const genresCollection = db.collection('genres');
        const genres = await genresCollection.find({}).toArray();
        res.json(genres);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для створення нового жанру
app.post('/genres', async (req, res) => {
    try {
        const { name } = req.body;
        if (!name) {
            return res.status(400).json({ message: 'Genre name is required' });
        }
        const db = client.db(dbName);
        const genresCollection = db.collection('genres');
        const result = await genresCollection.insertOne({ name });
        res.json(result.ops[0]);
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для отримання інформації про жанр за ID
app.get('/genres/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const genresCollection = db.collection('genres');
        const genre = await genresCollection.findOne({ _id: parseInt(id) });
        if (genre) {
            res.json(genre);
        } else {
            res.status(404).json({ message: 'Genre not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для оновлення інформації про жанр за ID
app.put('/genres/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { name } = req.body;
        if (!name) {
            return res.status(400).json({ message: 'Genre name is required' });
        }
        const db = client.db(dbName);
        const genresCollection = db.collection('genres');
        const result = await genresCollection.updateOne({ _id: parseInt(id) }, { $set: { name } });
        if (result.modifiedCount === 1) {
            res.json({ message: 'Genre updated successfully' });
        } else {
            res.status(404).json({ message: 'Genre not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Роут для видалення жанру за ID
app.delete('/genres/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const db = client.db(dbName);
        const genresCollection = db.collection('genres');
        const result = await genresCollection.deleteOne({ _id: parseInt(id) });
        if (result.deletedCount === 1) {
            res.json({ message: 'Genre deleted successfully' });
        } else {
            res.status(404).json({ message: 'Genre not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal server error' });
    }
});



// Запуск сервера
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
