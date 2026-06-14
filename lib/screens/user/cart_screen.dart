import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/cart_service.dart';
import 'checkout_screen.dart';

class CartScreen
    extends StatefulWidget {

  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {

  final CartService service =
  CartService();

  List<Map<String, dynamic>>
  carts = [];

  int total = 0;

  Future<void> loadData() async {

    final auth =
    context.read<
        AuthProvider>();

    carts =
    await service.getCart(
      auth.userId!,
    );

    total = 0;

    for (var item in carts) {
      total +=
          (item['price']
          as int) *
              (item['qty']
              as int);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(
          () => loadData(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text(
          "Keranjang",
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child: carts.isEmpty
                ? const Center(
              child: Text(
                "Keranjang Kosong",
              ),
            )
                : ListView.builder(
              itemCount:
              carts.length,

              itemBuilder:
                  (context,index){

                final item =
                carts[index];


                return ListTile(

                  leading:
                  Image.file(
                    File(
                      item[
                      'image'],
                    ),
                    width: 50,
                  ),

                  title: Text(
                    item['name'],
                  ),

                  subtitle: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Rp ${item['price']}",
                      ),

                      Text(
                        "Subtotal : Rp ${item['price'] * item['qty']}",
                      ),
                    ],
                  ),

                  trailing:
                  Row(
                    mainAxisSize:
                    MainAxisSize.min,

                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                        ),

                        onPressed: () async {

                          await service
                              .decreaseQty(
                            item['id'],
                            item['qty'],
                          );

                          loadData();
                        },
                      ),

                      Text(
                        item['qty']
                            .toString(),
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                        ),

                        onPressed: () async {

                          await service
                              .increaseQty(
                            item['id'],
                          );

                          loadData();
                        },
                      ),
                    ],
                  )

                );
              },
            ),
          ),

          Container(
            padding:
            const EdgeInsets.all(
                20),

            child: Column(
              children: [

                Text(
                  "Total : Rp $total",
                  style:
                  const TextStyle(
                    fontSize: 20,
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),

                const SizedBox(
                    height: 10),

                ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const CheckoutScreen(),
                      ),
                    ).then((_) {
                      loadData();
                    });
                  },

                  child: const Text(
                    "Checkout",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}