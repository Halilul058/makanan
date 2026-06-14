import 'package:flutter/material.dart';

import 'food_list_screen.dart';

class AdminDashboardScreen
    extends StatelessWidget {

  const AdminDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text(
          "Admin Ra Food",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(20),

        child: GridView.count(
          crossAxisCount: 2,

          crossAxisSpacing: 15,
          mainAxisSpacing: 15,

          children: [

            GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const FoodListScreen(),
                  ),
                );
              },

              child: Card(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: const [

                    Icon(
                      Icons.fastfood,
                      size: 50,
                    ),

                    SizedBox(
                        height: 10),

                    Text(
                      "Kelola Menu",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}