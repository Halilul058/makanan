import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class AuthService {
  final DatabaseHelper _dbHelper =
      DatabaseHelper.instance;

  Future<int> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final db = await _dbHelper.database;

    return await db.insert(
      'users',
      {
        'name': name,
        'email': email,
        'password': password,
        'role': 'user',
      },
    );
  }

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }
}