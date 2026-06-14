import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ProfileScreen
    extends StatelessWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    final auth =
    context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title:
        const Text(
          "Profil",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(
            20),

        child: Column(

          children: [

            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              auth.userName ??
                  "-",
              style:
              const TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              auth.role ??
                  "-",
            ),

            const Spacer(),

            SizedBox(
              width:
              double.infinity,

              child:
              ElevatedButton(
                onPressed:
                    () async {

                  await auth
                      .logout();

                  if (!context
                      .mounted) {
                    return;
                  }

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) =>
                    false,
                  );
                },

                child:
                const Text(
                  "Logout",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}