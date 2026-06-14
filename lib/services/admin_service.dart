import '../database/database_helper.dart';

class AdminService {

  final dbHelper =
      DatabaseHelper.instance;

  Future<int> getTotalMenu() async {

    final db =
    await dbHelper.database;

    final result =
    await db.rawQuery(
      '''
      SELECT COUNT(*) total
      FROM foods
      ''',
    );

    return result.first['total']
    as int;
  }

  Future<int> getTotalOrder() async {

    final db =
    await dbHelper.database;

    final result =
    await db.rawQuery(
      '''
      SELECT COUNT(*) total
      FROM orders
      ''',
    );

    return result.first['total']
    as int;
  }

  Future<int> getRevenue() async {

    final db =
    await dbHelper.database;

    final result =
    await db.rawQuery(
      '''
      SELECT
      IFNULL(
      SUM(total_price),
      0
      ) total

      FROM orders
      ''',
    );

    return result.first['total']
    as int;
  }
}