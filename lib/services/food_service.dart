import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class FoodService {
  final DatabaseHelper _db =
      DatabaseHelper.instance;

  Future<int> addFood(
      Map<String, dynamic> food) async {

    final db = await _db.database;

    return await db.insert(
      'foods',
      food,
    );
  }

  Future<List<Map<String, dynamic>>>
  getFoods() async {

    final db = await _db.database;

    return await db.query(
      'foods',
      orderBy: 'id DESC',
    );
  }

  Future<int> updateFood(
      Map<String, dynamic> food) async {

    final db = await _db.database;

    return await db.update(
      'foods',
      food,
      where: 'id = ?',
      whereArgs: [food['id']],
    );
  }

  Future<int> deleteFood(
      int id) async {

    final db = await _db.database;

    return await db.delete(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}