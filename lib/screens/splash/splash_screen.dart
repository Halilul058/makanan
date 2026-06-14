import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/routes.dart';

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

    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: const [
            Icon(
              Icons.restaurant_menu,
              size: 90,
              color: Colors.white,
            ),

            SizedBox(height: 20),

            Text(
              "Ra Food",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Warung Makanan Digital",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}