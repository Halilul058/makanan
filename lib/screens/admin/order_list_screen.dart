import 'package:flutter/material.dart';

import '../../services/order_service.dart';

class OrderListScreen
    extends StatefulWidget {

  const OrderListScreen({
    super.key,
  });

  @override
  State<OrderListScreen>
  createState() =>
      _OrderListScreenState();
}

class _OrderListScreenState
    extends State<OrderListScreen> {

  List<Map<String, dynamic>>
  orders = [];

  Future<void> loadData()
  async {

    orders =
    await OrderService()
        .getAllOrders();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Color getStatusColor(
      String status) {

    switch (status) {

      case "Pending":
        return Colors.orange;

      case "Diproses":
        return Colors.blue;

      case "Selesai":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Kelola Pesanan",
        ),
      ),

      body: ListView.builder(
        itemCount:
        orders.length,

        itemBuilder:
            (context, index) {

          final order =
          orders[index];

          return Card(
            margin:
            const EdgeInsets
                .all(10),

            child: Padding(
              padding:
              const EdgeInsets
                  .all(12),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [

                  Text(
                    "Order #${order['id']}",
                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Pelanggan : ${order['user_name']}",
                  ),

                  Text(
                    "Total : Rp ${order['total_price']}",
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),

                    decoration:
                    BoxDecoration(
                      color:
                      getStatusColor(
                        order['status'],
                      ),
                      borderRadius:
                      BorderRadius
                          .circular(
                        20,
                      ),
                    ),

                    child: Text(
                      order['status'],
                      style:
                      const TextStyle(
                        color:
                        Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [

                      Expanded(
                        child:
                        ElevatedButton(
                          onPressed:
                              () async {

                            await OrderService()
                                .updateOrderStatus(
                              orderId:
                              order['id'],
                              status:
                              "Diproses",
                            );

                            loadData();
                          },

                          child:
                          const Text(
                            "Diproses",
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child:
                        ElevatedButton(
                          onPressed:
                              () async {

                            await OrderService()
                                .updateOrderStatus(
                              orderId:
                              order['id'],
                              status:
                              "Selesai",
                            );

                            loadData();
                          },

                          child:
                          const Text(
                            "Selesai",
                          ),
                        ),
                      ),
                    ],
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