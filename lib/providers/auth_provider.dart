import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {

  int? userId;
  String? userName;
  String? role;

  bool get isLoggedIn =>
      userId != null;

  Future<void> saveSession({
    required int id,
    required String name,
    required String roleValue,
  }) async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setInt('user_id', id);
    await prefs.setString('user_name', name);
    await prefs.setString('role', roleValue);

    userId = id;
    userName = name;
    role = roleValue;

    notifyListeners();
  }

  Future<void> loadSession() async {

    final prefs =
    await SharedPreferences.getInstance();

    userId = prefs.getInt('user_id');
    userName = prefs.getString('user_name');
    role = prefs.getString('role');

    notifyListeners();
  }

  Future<void> logout() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.clear();

    userId = null;
    userName = null;
    role = null;

    notifyListeners();
  }
}