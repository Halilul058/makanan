import 'dart:io';

import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {

  final String name;
  final int price;
  final String image;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 180,
        margin: const EdgeInsets.only(
          right: 12,
        ),

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

                child: Image.file(
                  File(image),
                  height: 130,
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
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "Rp $price",
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}