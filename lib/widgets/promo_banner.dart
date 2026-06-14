import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(20),

        gradient:
        const LinearGradient(
          colors: [
            Color(0xFFFF7A00),
            Color(0xFFFFA64D),
          ],
        ),
      ),

      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Text(
              "Promo Hari Ini",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Diskon 20% semua menu",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}