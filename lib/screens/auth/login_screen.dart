import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/routes.dart';
import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';
import '../../config/app_colors.dart';



class LoginScreen extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState()
  => _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final AuthService authService =
  AuthService();

  Future<void> login() async {

    final user =
    await authService.login(
      email:
      emailController.text,
      password:
      passwordController.text,
    );

    if (user == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Login gagal"),
        ),
      );

      return;
    }

    await context
        .read<AuthProvider>()
        .saveSession(
      id: user['id'],
      name: user['name'],
      roleValue:
      user['role'],
    );

    if (!mounted) return;

    if (user['role'] ==
        'admin') {

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.adminDashboard,
      );

    } else {

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.userHome,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.restaurant_menu,
              size: 80,
              color: AppColors.primary,
            ),

            TextField(
              controller:
              emailController,
              decoration:
              const InputDecoration(
                hintText:
                "Email",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              passwordController,
              obscureText: true,
              decoration:
              const InputDecoration(
                hintText:
                "Password",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed:
              login,

              child:
              const Text(
                "Login",
              ),
            ),

            TextButton(
              onPressed: () {

                Navigator.pushNamed(
                  context,
                  AppRoutes.register,
                );
              },

              child: const Text(
                "Register",
              ),
            ),
          ],
        ),
      ),
    );
  }
}