import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import '../admin/admin_dashboard_screen.dart';
import '../user/user_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    startApp();
  }

  Future<void> startApp() async {

    final auth =
    context.read<AuthProvider>();

    await auth.loadSession();

    Timer(
      const Duration(seconds: 2),
          () {

        if (!mounted) return;

        if (!auth.isLoggedIn) {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const LoginScreen(),
            ),
          );

          return;
        }

        if (auth.role == "admin") {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AdminDashboardScreen(),
            ),
          );

        } else {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const UserHomeScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration:
        const BoxDecoration(
          gradient:
          LinearGradient(
            colors: [
              Color(0xffFF8A00),
              Color(0xffFFA940),
            ],
            begin:
            Alignment.topLeft,
            end:
            Alignment.bottomRight,
          ),
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Image.asset(
              "assets/images/logo.png",
              height: 120,
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
              "Ra Food",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Warung Makanan Digital",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}