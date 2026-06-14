import 'package:flutter/material.dart';

import '../../services/order_service.dart';

class OrderDetailScreen
    extends StatefulWidget {

  final int orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetailScreen>
  createState() =>
      _OrderDetailScreenState();
}

class _OrderDetailScreenState
    extends State<OrderDetailScreen> {

  List<Map<String, dynamic>>
  details = [];

  Future<void> loadData()
  async {

    details =
    await OrderService()
        .getOrderDetails(
      widget.orderId,
    );

    setState(() {});
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
      total +=
      item['subtotal']
      as int;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order #${widget.orderId}",
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child:
            ListView.builder(
              itemCount:
              details.length,

              itemBuilder:
                  (context,
                  index) {

                final item =
                details[index];

                return Card(
                  margin:
                  const EdgeInsets
                      .all(10),

                  child:
                  ListTile(

                    title: Text(
                      item['name'],
                    ),

                    subtitle:
                    Text(
                      "Qty : ${item['qty']}",
                    ),

                    trailing:
                    Text(
                      "Rp ${item['subtotal']}",
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding:
            const EdgeInsets
                .all(20),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [

                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                Text(
                  "Rp $total",
                  style:
                  const TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
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