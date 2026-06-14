import 'package:flutter/material.dart';

import '../../widgets/food_card.dart';
import '../../widgets/promo_banner.dart';

import 'cart_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() =>
      _UserHomeScreenState();
}

class _UserHomeScreenState
    extends State<UserHomeScreen> {

  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const CartScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
    const PromoBanner(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar:
      NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected:
            (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon:
            Icon(Icons.shopping_cart),
            label: "Keranjang",
          ),

          NavigationDestination(
            icon:
            Icon(Icons.history),
            label: "Riwayat",
          ),

          NavigationDestination(
            icon:
            Icon(Icons.person),
            label: "Profil",
          ),


        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(
              "Selamat Datang 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration:
              InputDecoration(
                hintText:
                "Cari makanan...",
                prefixIcon:
                const Icon(
                  Icons.search,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const PromoBanner(),
            SizedBox(
              width: double.infinity,
              child: PromoBanner(),
            ),

            const SizedBox(height: 25),

            const Text(
              "Kategori",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              children: const [
                Chip(
                  label:
                  Text("Makanan"),
                ),
                Chip(
                  label:
                  Text("Minuman"),
                ),
                Chip(
                  label:
                  Text("Snack"),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Menu Favorit",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 230,

              child: ListView(
                scrollDirection:
                Axis.horizontal,

                children: const [

                  FoodCard(
                    name:
                    "Nasi Goreng",
                    price:
                    "Rp15.000",
                    image:
                    "https://picsum.photos/300",
                  ),

                  FoodCard(
                    name:
                    "Ayam Geprek",
                    price:
                    "Rp18.000",
                    image:
                    "https://picsum.photos/301",
                  ),

                  FoodCard(
                    name:
                    "Mie Ayam",
                    price:
                    "Rp12.000",
                    image:
                    "https://picsum.photos/302",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}