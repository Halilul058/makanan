import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class RegisterScreen
    extends StatefulWidget {

  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen>
  createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final AuthService authService =
  AuthService();

  Future<void> register() async {

    await authService.register(
      name: nameController.text,
      email: emailController.text,
      password:
      passwordController.text,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
        Text("Register Berhasil"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Register"),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller:
              nameController,
              decoration:
              const InputDecoration(
                hintText:
                "Nama",
              ),
            ),

            const SizedBox(height: 15),

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
              register,

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