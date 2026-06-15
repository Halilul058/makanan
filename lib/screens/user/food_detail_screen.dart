import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/cart_service.dart';

class FoodDetailScreen
    extends StatelessWidget {

  final Map<String, dynamic> food;

  const FoodDetailScreen({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [

          /// FOTO MENU
          SizedBox(
            height: 320,
            width: double.infinity,

            child: Image.file(
              File(food['image']),
              fit: BoxFit.cover,
            ),
          ),

          /// TOMBOL BACK
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),

          /// DETAIL MENU
          DraggableScrollableSheet(
            initialChildSize: 0.68,
            minChildSize: 0.68,
            maxChildSize: 0.9,

            builder: (_, controller) {

              return Container(
                padding: const EdgeInsets.all(24),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),

                child: SingleChildScrollView(
                  controller: controller,

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Center(
                        child: Container(
                          width: 60,
                          height: 5,

                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        food['name'],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius:
                          BorderRadius.circular(20),
                        ),

                        child: Text(
                          "Rp ${food['price']}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [

                          Icon(
                            Icons.star,
                            color: Colors.amber.shade700,
                          ),

                          const SizedBox(width: 5),

                          const Text(
                            "4.8",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 15),

                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.red,
                          ),

                          SizedBox(width: 5),

                          Text(
                            "Best Seller",
                            style: TextStyle(
                              color:
                              Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Deskripsi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        food['description'],
                        style: TextStyle(
                          height: 1.6,
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: const BoxDecoration(
            color: Colors.white,
          ),

          child: SizedBox(
            height: 55,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16),
                ),
              ),

              onPressed: () async {

                final auth =
                context.read<AuthProvider>();

                await CartService()
                    .addToCart(
                  userId: auth.userId!,
                  foodId: food['id'],
                );

                if (!context.mounted) {
                  return;
                }

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Ditambahkan ke Keranjang",
                    ),
                  ),
                );
              },

              child: const Text(
                "Tambah ke Keranjang",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}