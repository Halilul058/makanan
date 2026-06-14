import 'dart:io';

import 'package:flutter/material.dart';

import '../../services/food_service.dart';
import 'add_food_screen.dart';
import 'edit_food_screen.dart';

class FoodListScreen
    extends StatefulWidget {

  const FoodListScreen({
    super.key,
  });

  @override
  State<FoodListScreen> createState() =>
      _FoodListScreenState();
}

class _FoodListScreenState
    extends State<FoodListScreen> {

  final FoodService service =
  FoodService();

  List<Map<String, dynamic>>
  foods = [];

  Future<void> loadData() async {

    foods =
    await service.getFoods();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> showDeleteDialog(
      int id) async {

    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text(
            "Hapus Menu",
          ),

          content: const Text(
            "Yakin ingin menghapus menu ini?",
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                    context);
              },

              child: const Text(
                "Batal",
              ),
            ),

            ElevatedButton(
              onPressed:
                  () async {

                await service
                    .deleteFood(
                  id,
                );

                if (!mounted)
                  return;

                Navigator.pop(
                    context);

                loadData();
              },

              child: const Text(
                "Hapus",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Menu",
        ),
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: () async {

          final result =
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddFoodScreen(),
            ),
          );

          if (result == true) {
            loadData();
          }
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      body: foods.isEmpty
          ? const Center(
        child: Text(
          "Belum ada menu",
        ),
      )
          : ListView.builder(
        itemCount:
        foods.length,

        itemBuilder:
            (context, index) {

          final food =
          foods[index];

          return Card(
            margin:
            const EdgeInsets
                .all(10),

            child: ListTile(

              leading:
              food['image'] !=
                  null &&
                  food['image'] !=
                      ''
                  ? ClipRRect(
                borderRadius:
                BorderRadius.circular(
                    10),
                child:
                Image.file(
                  File(
                    food[
                    'image'],
                  ),
                  width:
                  60,
                  height:
                  60,
                  fit: BoxFit
                      .cover,
                ),
              )
                  : const Icon(
                Icons
                    .fastfood,
              ),

              title: Text(
                food['name'],
              ),

              subtitle:
              Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [

                  Text(
                    "Rp ${food['price']}",
                  ),

                  Text(
                    "Stok : ${food['stock']}",
                  ),
                ],
              ),

              trailing: Row(
                mainAxisSize:
                MainAxisSize
                    .min,

                children: [

                  IconButton(
                    icon:
                    const Icon(
                      Icons
                          .edit,
                    ),

                    onPressed:
                        () async {

                      final result =
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                              EditFoodScreen(
                                food:
                                food,
                              ),
                        ),
                      );

                      if (result ==
                          true) {
                        loadData();
                      }
                    },
                  ),

                  IconButton(
                    icon:
                    const Icon(
                      Icons
                          .delete,
                    ),

                    onPressed:
                        () {
                      showDeleteDialog(
                        food[
                        'id'],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}