import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/order_service.dart';

import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() =>
      _OrderHistoryScreenState();
}

class _OrderHistoryScreenState
    extends State<OrderHistoryScreen> {

  List<Map<String, dynamic>> orders = [];

  Future<void> loadData() async {

    final auth =
    context.read<AuthProvider>();

    orders =
    await OrderService().getOrders(
      auth.userId!,
    );

    print("ORDER SCREEN DATA = $orders");

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
        title: const Text(
          "Riwayat Pesanan",
        ),
      ),

      body: orders.isEmpty
          ? const Center(
        child: Text(
          "Belum ada pesanan",
        ),
      )
          : ListView.builder(
        itemCount:
        orders.length,

        itemBuilder:
            (context, index) {

          final order =
          orders[index];

          return Card(
            margin:
            const EdgeInsets.all(
                10),

            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailScreen(
                      orderId: order['id'],
                    ),
                  ),
                );
              },

              leading: const CircleAvatar(
                child: Icon(
                  Icons.receipt,
                ),
              ),

              title: Text(
                "Order #${order['id']}",
              ),

              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    "Status: ${order['status']}",
                  ),

                  Text(
                    order['order_date']
                        .toString(),
                  ),
                ],
              ),

              trailing: Text(
                "Rp ${order['total_price']}",
              ),
            ),
          );
        },
      ),
    );
  }
}