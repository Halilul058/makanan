import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profil",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(
              height: 20,
            ),

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.orange,
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 55,
                backgroundColor:
                Color(0xffFFE0B2),

                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.deepOrange,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              auth.userName ?? "-",
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius:
                BorderRadius.circular(
                  20,
                ),
              ),

              child: Text(
                (auth.role ?? "-")
                    .toUpperCase(),

                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Card(
              elevation: 3,

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                  15,
                ),
              ),

              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.orange,
                ),

                title: const Text(
                  "Nama",
                ),

                subtitle: Text(
                  auth.userName ?? "-",
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Card(
              elevation: 3,

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                  15,
                ),
              ),

              child: ListTile(
                leading: const Icon(
                  Icons.badge,
                  color: Colors.orange,
                ),

                title: const Text(
                  "Role",
                ),

                subtitle: Text(
                  auth.role ?? "-",
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.logout,
                ),

                label: const Text(
                  "Logout",
                ),

                onPressed: () async {

                  final result =
                  await showDialog<bool>(
                    context: context,

                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          "Logout",
                        ),

                        content:
                        const Text(
                          "Yakin ingin logout?",
                        ),

                        actions: [

                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                false,
                              );
                            },

                            child:
                            const Text(
                              "Batal",
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                true,
                              );
                            },

                            child:
                            const Text(
                              "Ya",
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (result != true) {
                    return;
                  }

                  await auth.logout();

                  if (!context.mounted) {
                    return;
                  }

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) => false,
                  );
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}