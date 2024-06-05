const { MongoClient } = require('mongodb');

const url = 'mongodb://localhost:27017';

const dbName = 'library';

const client = new MongoClient(url);

async function setupDatabase() {
  try {
    // Підключення до сервера MongoDB
    await client.connect();

    // Використовувана база даних
    const db = client.db(dbName);

    const genresCollection = db.collection('genres');
    await genresCollection.insertMany([
      { "_id": 1, "name": "Дистопія" },
      { "_id": 2, "name": "Роман" },
      { "_id": 3, "name": "Фентезі" },
      { "_id": 4, "name": "Трагедія" },
      { "_id": 5, "name": "Детектив" },
      { "_id": 6, "name": "Пригоди" },
      { "_id": 7, "name": "Наукова фантастика" },
      { "_id": 8, "name": "Історичний роман" },
      { "_id": 9, "name": "Поезія" }
    ]);

    const authorsCollection = db.collection('authors');
    await authorsCollection.insertMany([
        { "_id": 1, "author_name": "Джордж Оруелл" },
        { "_id": 2, "author_name": "Джейн Остін" },
        { "_id": 3, "author_name": "Філіп К. Дік" },
        { "_id": 4, "author_name": "Дж. Р. Р. Толкін" },
        { "_id": 5, "author_name": "Вільям Шекспір" },
        { "_id": 6, "author_name": "Ернест Хемінгуей" },
        { "_id": 7, "author_name": "Агата Крісті" },
        { "_id": 8, "author_name": "Френсіс Скотт Фіцджеральд" },
        { "_id": 9, "author_name": "Марк Твен" },
        { "_id": 10, "author_name": "Чарльз Діккенс" },
        { "_id": 11, "author_name": "Тоні Моррісон" },
        { "_id": 12, "author_name": "Харпер Лі" },
        { "_id": 13, "author_name": "Джеймс Болдуїн" },
        { "_id": 14, "author_name": "Вірджинія Вульф" },
        { "_id": 15, "author_name": "Лео Толстой" },
        { "_id": 16, "author_name": "Джон Стейнбек" },
        { "_id": 17, "author_name": "Емілі Дікінсон" },
        { "_id": 18, "author_name": "Френк Герберт" },
        { "_id": 19, "author_name": "Достоєвський" },
        { "_id": 20, "author_name": "Тоні Моррісон" }
    ]);

    const usersCollection = db.collection('users');
    await usersCollection.insertMany([
        { "_id": 1, "username": "user1", "password": "pass1", "name": "Іван Петров", "contact_info": "ivan@example.com" },
        { "_id": 2, "username": "user2", "password": "pass2", "name": "Олена Іванова", "contact_info": "olena@example.com" },
        { "_id": 3, "username": "user3", "password": "pass3", "name": "Петро Сидоров", "contact_info": "petro@example.com" },
        { "_id": 4, "username": "admin", "password": "adminpass", "name": "Адміністратор", "contact_info": "admin@example.com" },
        { "_id": 5, "username": "user5", "password": "pass5", "name": "Марина Коваленко", "contact_info": "marina@example.com" },
        { "_id": 6, "username": "user6", "password": "pass6", "name": "Ігор Лисенко", "contact_info": "igor@example.com" },
        { "_id": 7, "username": "user7", "password": "pass7", "name": "Анна Семенова", "contact_info": "anna@example.com" },
        { "_id": 8, "username": "user8", "password": "pass8", "name": "Михайло Кравчук", "contact_info": "mikhailo@example.com" },
        { "_id": 9, "username": "user9", "password": "pass9", "name": "Олександра Левченко", "contact_info": "oleksandra@example.com" },
        { "_id": 10, "username": "user10", "password": "pass10", "name": "Артем Сорокін", "contact_info": "artem@example.com" },
        { "_id": 11, "username": "user11", "password": "pass11", "name": "Вікторія Жукова", "contact_info": "viktoria@example.com" },
        { "_id": 12, "username": "user12", "password": "pass12", "name": "Євген Поляков", "contact_info": "yevgen@example.com" },
        { "_id": 13, "username": "user13", "password": "pass13", "name": "Світлана Грищук", "contact_info": "svitlana@example.com" },
        { "_id": 14, "username": "user14", "password": "pass14", "name": "Денис Козлов", "contact_info": "denis@example.com" },
        { "_id": 15, "username": "user15", "password": "pass15", "name": "Наталія Морозова", "contact_info": "natalia@example.com" }
    ]);

    const booksCollection = db.collection('books');
await booksCollection.insertMany([
    { "_id": 1, "title": "1984", "author_id": 1, "genre_id": 1, "rating": 4.5, "year_published": 1949 },
    { "_id": 2, "title": "Поневіра (Стародавній Рим)", "author_id": 2, "genre_id": 2, "rating": 4.8, "year_published": 1813 },
    { "_id": 3, "title": "Мертві душі", "author_id": 3, "genre_id": 2, "rating": 4.2, "year_published": 1842 },
    { "_id": 4, "title": "Володар перснів", "author_id": 4, "genre_id": 3, "rating": 4.9, "year_published": 1954 },
    { "_id": 5, "title": "Ромео і Джульєтта", "author_id": 5, "genre_id": 4, "rating": 4.7, "year_published": 1597 },
    { "_id": 6, "title": "По ком звонить дзвін", "author_id": 6, "genre_id": 2, "rating": 4.6, "year_published": 1940 },
    { "_id": 7, "title": "Вбивство у Востеросі", "author_id": 7, "genre_id": 5, "rating": 4.9, "year_published": 1926 },
    { "_id": 8, "title": "Великий Гетсбі", "author_id": 8, "genre_id": 2, "rating": 4.7, "year_published": 1925 },
    { "_id": 9, "title": "Пригоди Гекльберрі Фінна", "author_id": 9, "genre_id": 6, "rating": 4.5, "year_published": 1884 },
    { "_id": 10, "title": "Олівер Твіст", "author_id": 10, "genre_id": 2, "rating": 4.3, "year_published": 1838 },
    { "_id": 11, "title": "Дорога", "author_id": 11, "genre_id": 2, "rating": 4.8, "year_published": 1997 },
    { "_id": 12, "title": "Убити пересмішника", "author_id": 12, "genre_id": 2, "rating": 4.9, "year_published": 1960 },
    { "_id": 13, "title": "Чорна красуня", "author_id": 13, "genre_id": 2, "rating": 4.4, "year_published": 1953 },
    { "_id": 14, "title": "Місіс Деллоуей", "author_id": 14, "genre_id": 2, "rating": 4.6, "year_published": 1925 },
    { "_id": 15, "title": "Війна і мир", "author_id": 15, "genre_id": 7, "rating": 4.9, "year_published": 1869 },
    { "_id": 16, "title": "Мишка", "author_id": 16, "genre_id": 2, "rating": 4.2, "year_published": 1937 },
    { "_id": 17, "title": "Поеми", "author_id": 5, "genre_id": 8, "rating": 4.8, "year_published": 1609 },
    { "_id": 18, "title": "Пісні", "author_id": 5, "genre_id": 8, "rating": 4.7, "year_published": 1609 },
    { "_id": 19, "title": "Герберт Свит", "author_id": 18, "genre_id": 9, "rating": 4.6, "year_published": 1965 },
    { "_id": 20, "title": "Брати Карамазови", "author_id": 19, "genre_id": 2, "rating": 4.9, "year_published": 1880 }
]);

    const copiesCollection = db.collection('copies');
    await copiesCollection.insertMany([
        { "_id": 1, "book_id": 1, "availability": "доступний" },
        { "_id": 2, "book_id": 1, "availability": "доступний" },
        { "_id": 3, "book_id": 2, "availability": "доступний" },
        { "_id": 4, "book_id": 3, "availability": "вибрано" },
        { "_id": 5, "book_id": 4, "availability": "доступний" },
        { "_id": 6, "book_id": 6, "availability": "доступний" },
        { "_id": 7, "book_id": 7, "availability": "вибрано" },
        { "_id": 8, "book_id": 8, "availability": "доступний" },
        { "_id": 9, "book_id": 9, "availability": "доступний" },
        { "_id": 10, "book_id": 10, "availability": "доступний" },
        { "_id": 11, "book_id": 11, "availability": "доступний" },
        { "_id": 12, "book_id": 12, "availability": "вибрано" },
        { "_id": 13, "book_id": 13, "availability": "доступний" },
        { "_id": 14, "book_id": 14, "availability": "доступний" },
        { "_id": 15, "book_id": 15, "availability": "доступний" },
        { "_id": 16, "book_id": 16, "availability": "доступний" },
        { "_id": 17, "book_id": 17, "availability": "доступний" },
        { "_id": 18, "book_id": 18, "availability": "доступний" },
        { "_id": 19, "book_id": 19, "availability": "вибрано" },
        { "_id": 20, "book_id": 20, "availability": "доступний" }
    ]);

    const loansCollection = db.collection('loans');
    await loansCollection.insertMany([
        { "_id": 1, "book_id": 1, "user_id": 1, "date_issued": new Date("2024-04-01"), "date_due": new Date("2024-04-15"), "date_returned": null },
        { "_id": 2, "book_id": 2, "user_id": 2, "date_issued": new Date("2024-04-05"), "date_due": new Date("2024-04-19"), "date_returned": null },
        { "_id": 3, "book_id": 3, "user_id": 3, "date_issued": new Date("2024-04-10"), "date_due": new Date("2024-04-24"), "date_returned": null },
        { "_id": 4, "book_id": 4, "user_id": 4, "date_issued": new Date("2024-04-15"), "date_due": new Date("2024-04-29"), "date_returned": null },
        { "_id": 5, "book_id": 5, "user_id": 5, "date_issued": new Date("2024-04-20"), "date_due": new Date("2024-05-04"), "date_returned": null },
        { "_id": 6, "book_id": 6, "user_id": 6, "date_issued": new Date("2024-04-25"), "date_due": new Date("2024-05-09"), "date_returned": null },
        { "_id": 7, "book_id": 7, "user_id": 7, "date_issued": new Date("2024-05-01"), "date_due": new Date("2024-05-15"), "date_returned": null },
        { "_id": 8, "book_id": 8, "user_id": 8, "date_issued": new Date("2024-05-05"), "date_due": new Date("2024-05-19"), "date_returned": null },
        { "_id": 9, "book_id": 9, "user_id": 9, "date_issued": new Date("2024-05-10"), "date_due": new Date("2024-05-24"), "date_returned": null },
        { "_id": 10, "book_id": 10, "user_id": 10, "date_issued": new Date("2024-05-15"), "date_due": new Date("2024-05-29"), "date_returned": null },
        { "_id": 11, "book_id": 11, "user_id": 11, "date_issued": new Date("2024-05-20"), "date_due": new Date("2024-06-03"), "date_returned": null },
        { "_id": 12, "book_id": 12, "user_id": 12, "date_issued": new Date("2024-05-25"), "date_due": new Date("2024-06-08"), "date_returned": null },
        { "_id": 13, "book_id": 13, "user_id": 13, "date_issued": new Date("2024-05-30"), "date_due": new Date("2024-06-13"), "date_returned": null },
        { "_id": 14, "book_id": 14, "user_id": 14, "date_issued": new Date("2024-06-05"), "date_due": new Date("2024-06-19"), "date_returned": null },
        { "_id": 15, "book_id": 15, "user_id": 15, "date_issued": new Date("2024-06-10"), "date_due": new Date("2024-06-24"), "date_returned": null }
    ]);

    console.log('Database setup complete!');
  } catch (err) {
    console.error('Error setting up database:', err);
  } finally {
    // Закриття з'єднання з сервером MongoDB
    await client.close();
  }
}

setupDatabase();