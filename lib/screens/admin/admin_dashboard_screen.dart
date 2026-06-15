import 'package:flutter/material.dart';

import '../../services/admin_service.dart';
import 'food_list_screen.dart';
import 'order_list_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class AdminDashboardScreen
    extends StatefulWidget {

  const AdminDashboardScreen({
    super.key,
  });

  @override
  State<AdminDashboardScreen>
  createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<
        AdminDashboardScreen> {

  int totalMenu = 0;
  int totalOrder = 0;
  int revenue = 0;

  Future<void> loadData()
  async {

    final service =
    AdminService();

    totalMenu =
    await service
        .getTotalMenu();

    totalOrder =
    await service
        .getTotalOrder();

    revenue =
    await service
        .getRevenue();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Admin Ra Food",
        ),

        actions: [

          IconButton(
            icon: const Icon(
              Icons.logout,
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

                    content: const Text(
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

                        child: const Text(
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

                        child: const Text(
                          "Ya",
                        ),
                      ),
                    ],
                  );
                },
              );

              if (result != true) return;

              await context
                  .read<AuthProvider>()
                  .logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const LoginScreen(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(
            20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [

            Container(
              width:
              double.infinity,

              padding:
              const EdgeInsets
                  .all(20),

              decoration:
              BoxDecoration(
                borderRadius:
                BorderRadius
                    .circular(
                    20),

                gradient:
                const LinearGradient(
                  colors: [
                    Color(
                        0xffFF8A00),
                    Color(
                        0xffFFA940),
                  ],
                ),
              ),

              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [

                  Text(
                    "Selamat Datang 👨‍🍳",
                    style:
                    TextStyle(
                      color:
                      Colors.white,
                      fontSize:
                      24,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Kelola warung dengan mudah",
                    style:
                    TextStyle(
                      color:
                      Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [

                Expanded(
                  child:
                  statCard(
                    "Menu",
                    totalMenu
                        .toString(),
                    Icons.fastfood,
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                Expanded(
                  child:
                  statCard(
                    "Order",
                    totalOrder
                        .toString(),
                    Icons.receipt,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            Container(
              width:
              double.infinity,

              padding:
              const EdgeInsets
                  .all(20),

              decoration:
              BoxDecoration(
                color:
                Colors.white,
                borderRadius:
                BorderRadius
                    .circular(
                    20),
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [

                  const Text(
                    "Pendapatan",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Rp $revenue",
                    style:
                    const TextStyle(
                      fontSize:
                      24,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            SizedBox(
              width:
              double.infinity,

              child:
              ElevatedButton.icon(
                icon:
                const Icon(
                  Icons.fastfood,
                ),

                label:
                const Text(
                  "Kelola Menu",
                ),

                onPressed:
                    () async {

                  await Navigator
                      .push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                      const FoodListScreen(),
                    ),
                  );

                  loadData();
                },
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.receipt_long,
                ),

                label: const Text(
                  "Kelola Pesanan",
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const OrderListScreen(),
                    ),
                  );
                },
              ),
            ),



          ],
        ),
      ),
    );
  }

  Widget statCard(
      String title,
      String value,
      IconData icon,
      ) {

    return Container(
      padding:
      const EdgeInsets.all(
          20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(
            20),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            size: 35,
          ),

          const SizedBox(
            height: 10,
          ),

          Text(title),

          Text(
            value,
            style:
            const TextStyle(
              fontSize: 22,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}