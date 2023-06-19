import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:teriyaki_bowl_app/views/payment_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';
import 'coupon_screen.dart';

class OrderSummaryScreen extends StatefulWidget {
  final snap;
  final double tax;
  final int totalOrder;

  const OrderSummaryScreen(
      {super.key,
      required this.snap,
      required this.tax,
      required this.totalOrder});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  TextEditingController couponController = TextEditingController();

  var couponData = {};
  double totalAmount = 0.00;

  double discount = 0.00;
  String cid = "";
  bool couponApplied = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  getData() async {
    try {
      var couponSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('coupons')
          .get();

      couponData = couponSnap.data()!;

      setState(() {});
    } catch (e) {
    }
  }

  @override
  void dispose() {
    super.dispose();
    couponController.dispose();
  }

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
          "Order Summary",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      12.heightBox,
                      const Text(
                        "Order Summary",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      12.heightBox,
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 16, left: 16, bottom: 8),
                          child: ListView.builder(
                              itemCount: widget.snap['items'].length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  decelerationRate:
                                      ScrollDecelerationRate.fast),
                              itemBuilder: (BuildContext context, index) {
                                var itemSnap =
                                    widget.snap[widget.snap['items'][index]];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${itemSnap['item_name']}"
                                              .allWordsCapitilize(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      8.widthBox,
                                      Text(
                                        "${itemSnap['quantity']} x \$${itemSnap['item_price'].toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      8.widthBox,
                                      Text(
                                        "\$${itemSnap['total_price'].toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      12.heightBox,
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 16, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Coupon Code",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  8.widthBox,
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => CouponScreen(
                                            data: couponData,
                                          ));
                                    },
                                    child: const Text(
                                      "Select Promo Code",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              8.heightBox,
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        controller: couponController,
                                        labelText: "Enter Promo code",
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    8.widthBox,
                                    couponApplied
                                        ? CustomButton(
                                            btnText: "Apply",
                                            isDisabled: true,
                                            paddingH: 16,
                                            paddingV: 16,
                                            onTap: () {},
                                          )
                                        : CustomButton(
                                            btnText: "Apply",
                                            paddingH: 16,
                                            paddingV: 16,
                                            onTap: () {
                                              if (couponData['code_list']
                                                  .contains(
                                                      couponController.text)) {
                                                setState(() {
                                                  discount = couponData[
                                                          couponController
                                                              .text]['discount']
                                                      .toDouble();
                                                  cid = couponController.text;
                                                  couponApplied = true;
                                                });
                                              } else {
                                                showSnackBar(
                                                    "Wrong coupon code",
                                                    context);
                                              }
                                            },
                                          ),
                                  ],
                                ),
                              ),
                              couponApplied
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Coupon Code Applied Successfully!",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      12.heightBox,
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
                                          "Payment Summary",
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
                                      const Expanded(
                                        child: Text(
                                          "Order Total",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${widget.snap['cart_amount'].toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  8.heightBox,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Tax (${widget.tax}%)",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${(widget.snap['cart_amount'] * (widget.tax / 100.00)).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  8.heightBox,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Discount ($discount%)",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${(widget.snap['cart_amount'] * (discount.toDouble() / 100.00)).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: primaryColor),
                                    ),
                                  ),
                                  Text(
                                    "\$${(widget.snap['cart_amount'] + (widget.snap['cart_amount'] * (widget.tax / 100.00)) - (widget.snap['cart_amount'] * (discount.toDouble() / 100.00))).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      16.heightBox,
                    ],
                  ),
                ),
              ),
              CustomButton(
                btnText: "Proceed to Payment",
                onTap: () {
                  setState(() {
                    totalAmount = (widget.snap['cart_amount'] +
                        (widget.snap['cart_amount'] * (widget.tax / 100.00)) -
                        (widget.snap['cart_amount'] *
                            (discount.toDouble() / 100.00)));
                  });
                  Get.to(() => PaymentScreen(
                        totalAmount: totalAmount,
                        totalOrder: widget.totalOrder,
                        discount: discount,
                        cid: cid,
                        snap: widget.snap,
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
