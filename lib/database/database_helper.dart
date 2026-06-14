import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
  DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(
      await getDatabasesPath(),
      'ra_food.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async {
        await db.execute(
          'PRAGMA foreign_keys = ON',
        );
      },
    );
  }

  Future _createDB(
      Database db,
      int version) async {

    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        password TEXT,
        role TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE foods(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price INTEGER,
        description TEXT,
        image TEXT,
        stock INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE carts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        food_id INTEGER,
        qty INTEGER,

        FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

        FOREIGN KEY(food_id)
        REFERENCES foods(id)
        ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        total_price INTEGER,
        order_date TEXT,
        status TEXT,

        FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE order_details(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER,
        food_id INTEGER,
        qty INTEGER,
        price INTEGER,
        subtotal INTEGER,

        FOREIGN KEY(order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,

        FOREIGN KEY(food_id)
        REFERENCES foods(id)
        ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE payments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER,
        payment_method TEXT,
        payment_status TEXT,
        payment_date TEXT,

        FOREIGN KEY(order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE
      )
    ''');

    await _seedAdmin(db);
  }

  Future<void> _seedAdmin(
      Database db) async {

    await db.insert(
      'users',
      {
        'name': 'Administrator',
        'email': 'admin@rafood.com',
        'password': 'admin123',
        'role': 'admin',
      },
    );
  }
}