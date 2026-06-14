import 'package:flutter/material.dart';

import '../../widgets/food_card.dart';
import '../../widgets/promo_banner.dart';

import 'cart_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import '../../services/food_service.dart';

import 'food_detail_screen.dart';
import 'order_history_screen.dart';

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
    const OrderHistoryScreen(),
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

class HomePage extends StatefulWidget {

  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  final FoodService service =
  FoodService();

  List<Map<String, dynamic>>
  foods = [];

  List<Map<String, dynamic>>
  filteredFoods = [];

  Future<void> loadData() async {

    foods =
    await service.getFoods();

    filteredFoods =
        List.from(foods);

    setState(() {});
  }

  Future<void> searchFood(
      String keyword) async {

    if (keyword.isEmpty) {

      filteredFoods =
          List.from(foods);

    } else {

      filteredFoods =
      await service
          .searchFoods(
        keyword,
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

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

            const SizedBox(
              height: 20,
            ),

            TextField(
              onChanged:
              searchFood,

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

            const SizedBox(
              height: 20,
            ),

            const PromoBanner(),

            const SizedBox(
              height: 25,
            ),

            const Text(
              "Menu Tersedia",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            foods.isEmpty
                ? const Padding(
              padding:
              EdgeInsets.all(
                  20),
              child: Center(
                child: Text(
                  "Belum ada menu",
                ),
              ),
            )
                : SizedBox(
              height: 250,

              child:
              ListView.builder(
                scrollDirection:
                Axis.horizontal,

                itemCount:
                filteredFoods.length,

                itemBuilder:
                    (context,
                    index) {

                  final food =
                  filteredFoods[index];

                  return FoodCard(
                    name:
                    food['name'],

                    price:
                    food['price'],

                    image:
                    food['image'],

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder:
                              (_) =>
                              FoodDetailScreen(
                                food:
                                food,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}