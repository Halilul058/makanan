import 'package:flutter/material.dart';

import '../../services/order_service.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetailScreen> createState() =>
      _OrderDetailScreenState();
}

class _OrderDetailScreenState
    extends State<OrderDetailScreen> {

  List<Map<String, dynamic>> details = [];
  bool isLoading = true;

  Future<void> loadData() async {
    try {
      details = await OrderService()
          .getOrderDetails(
        widget.orderId,
      );

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {

    int total = 0;

    for (var item in details) {
      total += item['subtotal'] as int;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Order #${widget.orderId}",
        ),
      ),

      body: isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : details.isEmpty
          ? const Center(
        child: Text(
          "Belum ada detail pesanan",
        ),
      )
          : Column(
        children: [

          Expanded(
            child: ListView.builder(
              padding:
              const EdgeInsets.all(
                  16),
              itemCount:
              details.length,
              itemBuilder:
                  (context, index) {

                final item =
                details[index];

                return Container(
                  margin:
                  const EdgeInsets
                      .only(
                    bottom: 14,
                  ),

                  decoration:
                  BoxDecoration(
                    color:
                    Colors.white,
                    borderRadius:
                    BorderRadius
                        .circular(
                        20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors
                            .black
                            .withOpacity(
                            0.08),
                        blurRadius:
                        10,
                        offset:
                        const Offset(
                            0,
                            4),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding:
                    const EdgeInsets
                        .all(16),

                    child: Row(
                      children: [

                        Container(
                          width: 50,
                          height: 50,

                          decoration:
                          BoxDecoration(
                            color:
                            Colors.orange
                                .shade100,
                            borderRadius:
                            BorderRadius.circular(
                                12),
                          ),

                          child:
                          const Icon(
                            Icons
                                .fastfood,
                            color: Colors
                                .orange,
                          ),
                        ),

                        const SizedBox(
                          width: 14,
                        ),

                        Expanded(
                          child:
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [

                              Text(
                                item[
                                'name'],
                                style:
                                const TextStyle(
                                  fontSize:
                                  17,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height:
                                4,
                              ),

                              Text(
                                "Qty : ${item['qty']}",
                                style:
                                TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          "Rp ${item['subtotal']}",
                          style:
                          const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
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
            const EdgeInsets.all(
                20),

            decoration:
            const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.only(
                topLeft:
                Radius.circular(
                    24),
                topRight:
                Radius.circular(
                    24),
              ),
            ),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [

                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                Text(
                  "Rp $total",
                  style:
                  const TextStyle(
                    fontSize: 20,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Colors.orange,
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