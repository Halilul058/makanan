import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/order_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
  });

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {

  String paymentMethod = 'Cash';

  Future<void> processOrder() async {

    final auth =
    context.read<AuthProvider>();

    await OrderService().checkout(
      userId: auth.userId!,
      paymentMethod: paymentMethod,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Pesanan Berhasil",
        ),
      ),
    );

    Navigator.pop(context);
  }

  Widget paymentCard({
    required String title,
    required IconData icon,
  }) {

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
            color:
            Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 10,
            offset:
            const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: RadioListTile<String>(
        value: title,
        groupValue: paymentMethod,

        activeColor:
        Colors.orange,

        secondary: Icon(
          icon,
          color: Colors.orange,
          size: 28,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight:
            FontWeight.w600,
            fontSize: 16,
          ),
        ),

        onChanged: (value) {

          setState(() {
            paymentMethod = value!;
          });
        },
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      backgroundColor:
      const Color(
        0xffF5F6FA,
      ),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:
        Colors.white,

        title: const Text(
          "Checkout",
          style: TextStyle(
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            paymentCard(
              title: "Cash",
              icon:
              Icons.payments,
            ),

            paymentCard(
              title:
              "Transfer Bank",
              icon:
              Icons.account_balance,
            ),

            paymentCard(
              title:
              "E-Wallet",
              icon: Icons
                  .account_balance_wallet,
            ),

            const SizedBox(
              height: 10,
            ),

            Container(
              width:
              double.infinity,

              padding:
              const EdgeInsets.all(
                20,
              ),

              decoration:
              BoxDecoration(
                color:
                Colors.white,

                borderRadius:
                BorderRadius
                    .circular(
                  20,
                ),

                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black
                        .withOpacity(
                      0.05,
                    ),
                    blurRadius:
                    10,
                    offset:
                    const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [

                  const Text(
                    "Informasi Pesanan",
                    style:
                    TextStyle(
                      fontSize:
                      18,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      const Text(
                        "Metode",
                      ),

                      Text(
                        paymentMethod,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      Text(
                        "Status",
                      ),

                      Text(
                        "Menunggu Pembayaran",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width:
              double.infinity,
              height: 58,

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
                    BorderRadius
                        .circular(
                      16,
                    ),
                  ),
                ),

                onPressed:
                processOrder,

                child:
                const Text(
                  "Buat Pesanan",
                  style:
                  TextStyle(
                    color:
                    Colors.white,
                    fontSize:
                    16,
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}