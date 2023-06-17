import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/resources/firestore_methods.dart';
import 'package:teriyaki_bowl_app/views/cards/cart_card.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:teriyaki_bowl_app/views/order_placed_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import 'order_summary_screen.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final int totalOrder;
  final double discount;
  final String cid;
  final snap;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    required this.totalOrder,
    required this.discount,
    required this.cid,
    required this.snap,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCod = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Payment",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
            color: primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Payment Method",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        12.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isCod
                                        ? primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Text(
                                      "COD",
                                      style: TextStyle(
                                        color: isCod ? lightColor : darkColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            8.widthBox,
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isCod
                                        ? Colors.transparent
                                        : primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "ONLINE PAY",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                isCod ? darkColor : lightColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "NOT AVAILABLE",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                isCod ? darkColor : lightColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            28.heightBox,
            Expanded(
              child: Text(
                "Total Payable Amount: \$${widget.totalAmount.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            12.heightBox,
            isLoading? const Center(child: CircularProgressIndicator(color: primaryColor,),): CustomButton(
              btnText: "Complete Order",
              onTap: () async {

                setState(() {
                  isLoading = true;
                });

                DateTime now = DateTime.now();
                String formattedDate = DateFormat('dd/MM/yy kk:mm:ss').format(now);

                String oid = "${widget.totalOrder+1}";

                await FirestoreMethods().saveOrder(
                  oid: oid,
                  orderStatus: 0,
                  paymentCompleted: false,
                  isCOD: true,
                  orderTotal: widget.totalAmount,
                  discount: widget.discount,
                  couponCode: widget.cid,
                  cart: widget.snap.data(),
                  orderTime: formattedDate,
                  context: context,
                );

                await resetCartFunction();

                await FirestoreMethods().updateOrder(totalOrder: (widget.totalOrder+1));

                setState(() {
                  isLoading = false;
                });

                Get.close(3);
                Get.to(() => const OrderPlacedScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetCartFunction() async {
    await FirestoreMethods().resetCart(context: context);
  }
}
