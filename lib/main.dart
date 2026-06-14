import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/user/user_home_screen.dart';
import 'config/app_theme.dart';
import 'config/routes.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/splash/splash_screen.dart';

import 'screens/admin/add_food_screen.dart';

void main() {
  runApp(

    ChangeNotifierProvider(
      create: (_) =>
          AuthProvider(),

      child:
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Ra Food',

      theme: AppTheme.lightTheme,

      initialRoute: AppRoutes.splash,

      routes: {
        AppRoutes.splash:
            (context) =>
        const SplashScreen(),

        AppRoutes.login:
            (context) =>
        const LoginScreen(),

        AppRoutes.register:
            (context) =>
        const RegisterScreen(),

        AppRoutes.adminDashboard: (context) =>
        const AdminDashboardScreen(),

        AppRoutes.userHome: (context) =>
        const UserHomeScreen(),

        AppRoutes.addFood: (context) =>
        const AddFoodScreen(),



      },
    );
  }
}