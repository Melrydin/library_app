import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import 'models/widgets/book.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return await open();
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY,
        category TEXT NOT NULL,
        title TEXT NOT NULL,
        series INTEGER NOT NULL,
        volumeInfo INTEGER NOT NULL,
        author TEXT NOT NULL,
        publisher TEXT NOT NULL,
        price REAL NOT NULL,
        isbn INTEGER NOT NULL,
        wishList INTEGER NOT NULL,
        releaseDate INTEGER NOT NULL,
        startDate INTEGER NOT NULL,
        endDate INTEGER NOT NULL,
        payDate INTEGER NOT NULL
      )
    ''');
  }

  Future<List<Book>> getBooksList(int wishList, String category) async {
    Database db = await instance.database;
    var books = await db.query('books', orderBy: 'title', where: 'wishList = ? and category = ? ', whereArgs: [wishList, category]);
    List<Book> booksList = books.isNotEmpty ? books.map((book) => Book.fromMap(book)).toList() : [];
    return booksList;
  }

  Future<Book> getBook(int id) async {
    Database db = await instance.database;
    final maps = await db.query('books', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Book.fromMap(maps.first);
    } else {
      throw Exception('Book not found');
    }
  }

  Future<int> add(Book book) async {
    Database db = await instance.database;
    return await db.insert('books', book.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Book book) async {
    Database db = await instance.database;
    return await db.update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
  }

  Future close() async {
    Database db = await instance.database;
    return db.close();
  }

  Future open() async {
    return openDatabase(
      join(await getDatabasesPath(), 'library_app.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }
}
