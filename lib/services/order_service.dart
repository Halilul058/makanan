import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class OrderService {

  final DatabaseHelper dbHelper =
      DatabaseHelper.instance;

  Future<void> checkout({
    required int userId,
    required String paymentMethod,
  }) async {

    final db =
    await dbHelper.database;

    final carts =
    await db.rawQuery(
      '''
      SELECT
      carts.*,
      foods.price

      FROM carts

      JOIN foods
      ON carts.food_id = foods.id

      WHERE carts.user_id = ?
      ''',
      [userId],
    );

    if (carts.isEmpty) return;

    int total = 0;

    for (var item in carts) {
      total +=
          (item['price'] as int) *
              (item['qty'] as int);
    }

    final orderId =
    await db.insert(
      'orders',
      {
        'user_id': userId,
        'total_price': total,
        'order_date':
        DateTime.now()
            .toString(),
        'status': 'Pending',
      },
    );

    print("ORDER ID = $orderId");

    for (var item in carts) {

      final price =
      item['price'] as int;

      final qty =
      item['qty'] as int;

      await db.insert(
        'order_details',
        {
          'order_id': orderId,
          'food_id':
          item['food_id'],
          'qty': qty,
          'price': price,
          'subtotal':
          price * qty,
        },
      );
    }

    await db.insert(
      'payments',
      {
        'order_id': orderId,
        'payment_method':
        paymentMethod,
        'payment_status':
        'Menunggu',
        'payment_date':
        DateTime.now()
            .toString(),
      },
    );

    await db.delete(
      'carts',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getOrders(
      int userId) async {

    final db = await dbHelper.database;

    final result = await db.query(
      'orders',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );

    print("USER ID HISTORY = $userId");
    print("DATA ORDER = $result");

    return result;
  }

  Future<List<Map<String, dynamic>>>
  getOrderDetails(
      int orderId) async {

    final db =
    await dbHelper.database;

    return await db.rawQuery(
      '''
    SELECT

    order_details.*,
    foods.name

    FROM order_details

    JOIN foods
    ON order_details.food_id = foods.id

    WHERE order_id = ?
    ''',
      [orderId],
    );
  }

  Future<List<Map<String, dynamic>>>
  getAllOrders() async {

    final db =
    await dbHelper.database;

    return await db.rawQuery('''
    SELECT
    orders.*,
    users.name as user_name

    FROM orders

    JOIN users
    ON orders.user_id = users.id

    ORDER BY orders.id DESC
  ''');
  }

  Future<int> updateOrderStatus({
    required int orderId,
    required String status,
  }) async {

    final db =
    await dbHelper.database;

    return await db.update(
      'orders',
      {
        'status': status,
      },
      where: 'id = ?',
      whereArgs: [orderId],
    );
  }
}