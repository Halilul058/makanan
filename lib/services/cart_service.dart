import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class CartService {

  final DatabaseHelper dbHelper =
      DatabaseHelper.instance;

  Future<int> addToCart({
    required int userId,
    required int foodId,
  }) async {

    final db =
    await dbHelper.database;

    final existing =
    await db.query(
      'carts',
      where:
      'user_id = ? AND food_id = ?',
      whereArgs: [
        userId,
        foodId,
      ],
    );

    if (existing.isNotEmpty) {

      int qty =
      existing.first['qty']
      as int;

      return await db.update(
        'carts',
        {
          'qty': qty + 1,
        },
        where: 'id = ?',
        whereArgs: [
          existing.first['id']
        ],
      );
    }

    return await db.insert(
      'carts',
      {
        'user_id': userId,
        'food_id': foodId,
        'qty': 1,
      },
    );
  }

  Future<List<Map<String, dynamic>>>
  getCart(int userId) async {

    final db =
    await dbHelper.database;

    return await db.rawQuery('''
      SELECT
      carts.id,
      carts.qty,

      foods.id as food_id,
      foods.name,
      foods.price,
      foods.image

      FROM carts

      JOIN foods
      ON carts.food_id = foods.id

      WHERE carts.user_id = ?
    ''', [userId]);
  }

  Future<void> deleteCart(
      int cartId) async {

    final db =
    await dbHelper.database;

    await db.delete(
      'carts',
      where: 'id = ?',
      whereArgs: [cartId],
    );
  }

  Future<void> updateQty({
    required int cartId,
    required int qty,
  }) async {

    final db =
    await dbHelper.database;

    await db.update(
      'carts',
      {'qty': qty},
      where: 'id = ?',
      whereArgs: [cartId],
    );
  }

  Future<void> increaseQty(
      int cartId) async {

    final db =
    await dbHelper.database;

    await db.rawUpdate(
      '''
    UPDATE carts
    SET qty = qty + 1
    WHERE id = ?
    ''',
      [cartId],
    );
  }

  Future<void> decreaseQty(
      int cartId,
      int currentQty,
      ) async {

    final db =
    await dbHelper.database;

    if (currentQty <= 1) {

      await deleteCart(
        cartId,
      );

      return;
    }

    await db.rawUpdate(
      '''
    UPDATE carts
    SET qty = qty - 1
    WHERE id = ?
    ''',
      [cartId],
    );
  }
}