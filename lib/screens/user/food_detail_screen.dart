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
      appBar: AppBar(
        title:
        Text(food['name']),
      ),

      body: Column(
        children: [

          Image.file(
            File(food['image']),
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),

          Padding(
            padding:
            const EdgeInsets.all(
                20),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [

                Text(
                  food['name'],
                  style:
                  const TextStyle(
                    fontSize: 24,
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),

                const SizedBox(
                    height: 10),

                Text(
                  "Rp ${food['price']}",
                  style:
                  const TextStyle(
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                    height: 20),

                Text(
                  food[
                  'description'],
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar:
      Padding(
        padding:
        const EdgeInsets.all(
            16),

        child: ElevatedButton(
          onPressed: () async {

            final auth =
            context.read<
                AuthProvider>();

            await CartService()
                .addToCart(
              userId:
              auth.userId!,
              foodId:
              food['id'],
            );

            if (!context.mounted)
              return;

            ScaffoldMessenger.of(
                context)
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
          ),
        ),
      ),
    );
  }
}