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
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Keranjang",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child: carts.isEmpty

                ? const Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Keranjang Kosong",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )

                : ListView.builder(
              padding:
              const EdgeInsets.all(16),

              itemCount: carts.length,

              itemBuilder:
                  (context, index) {

                final item =
                carts[index];

                return Container(
                  margin:
                  const EdgeInsets.only(
                    bottom: 15,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset:
                        const Offset(
                          0,
                          3,
                        ),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding:
                    const EdgeInsets.all(
                      12,
                    ),

                    child: Row(
                      children: [

                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),

                          child: Image.file(
                            File(
                              item['image'],
                            ),

                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              Text(
                                item['name'],
                                style:
                                const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                "Rp ${item['price']}",
                                style:
                                TextStyle(
                                  color:
                                  Colors.grey.shade700,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Text(
                                "Subtotal : Rp ${item['price'] * item['qty']}",
                                style:
                                const TextStyle(
                                  color:
                                  Colors.orange,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          children: [

                            Row(
                              children: [

                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor:
                                  Colors.orange
                                      .shade100,

                                  child: IconButton(
                                    padding:
                                    EdgeInsets.zero,

                                    icon:
                                    const Icon(
                                      Icons.remove,
                                      size: 18,
                                    ),

                                    onPressed:
                                        () async {

                                      await service
                                          .decreaseQty(
                                        item['id'],
                                        item['qty'],
                                      );

                                      loadData();
                                    },
                                  ),
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                    horizontal:
                                    10,
                                  ),

                                  child: Text(
                                    item['qty']
                                        .toString(),

                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),

                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor:
                                  Colors.orange,

                                  child: IconButton(
                                    padding:
                                    EdgeInsets.zero,

                                    icon:
                                    const Icon(
                                      Icons.add,
                                      size: 18,
                                      color:
                                      Colors.white,
                                    ),

                                    onPressed:
                                        () async {

                                      await service
                                          .increaseQty(
                                        item['id'],
                                      );

                                      loadData();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding:
            const EdgeInsets.all(20),

            decoration:
            const BoxDecoration(
              color: Colors.white,

              borderRadius:
              BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),

            child: SafeArea(
              child: Column(
                mainAxisSize:
                MainAxisSize.min,

                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      const Text(
                        "Total Pembayaran",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        "Rp $total",
                        style:
                        const TextStyle(
                          fontSize: 24,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    width:
                    double.infinity,
                    height: 55,

                    child:
                    ElevatedButton(
                      style:
                      ElevatedButton
                          .styleFrom(
                        backgroundColor:
                        Colors.orange,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),

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
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}