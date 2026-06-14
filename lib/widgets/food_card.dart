import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const FoodCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}