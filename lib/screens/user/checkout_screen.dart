import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/order_service.dart';

class CheckoutScreen
    extends StatefulWidget {

  const CheckoutScreen({
    super.key,
  });

  @override
  State<CheckoutScreen>
  createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<
        CheckoutScreen> {

  String paymentMethod =
      'Cash';

  Future<void> processOrder()
  async {

    final auth =
    context.read<
        AuthProvider>();

    await OrderService()
        .checkout(
      userId:
      auth.userId!,
      paymentMethod:
      paymentMethod,
    );
    print("HISTORY USER ID = ${auth.userId}");

    if (!mounted) return;

    ScaffoldMessenger.of(
        context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Pesanan Berhasil",
        ),
      ),
    );

    Navigator.pop(
      context,
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text(
          "Checkout",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(
            20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [

            const Text(
              "Metode Pembayaran",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            RadioListTile(
              value: "Cash",
              groupValue:
              paymentMethod,
              title:
              const Text(
                "Cash",
              ),
              onChanged:
                  (value) {

                setState(() {
                  paymentMethod =
                  value!;
                });
              },
            ),

            RadioListTile(
              value:
              "Transfer Bank",
              groupValue:
              paymentMethod,
              title:
              const Text(
                "Transfer Bank",
              ),
              onChanged:
                  (value) {

                setState(() {
                  paymentMethod =
                  value!;
                });
              },
            ),

            RadioListTile(
              value:
              "E-Wallet",
              groupValue:
              paymentMethod,
              title:
              const Text(
                "E-Wallet",
              ),
              onChanged:
                  (value) {

                setState(() {
                  paymentMethod =
                  value!;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width:
              double.infinity,

              child:
              ElevatedButton(
                onPressed:
                processOrder,

                child:
                const Text(
                  "Buat Pesanan",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}