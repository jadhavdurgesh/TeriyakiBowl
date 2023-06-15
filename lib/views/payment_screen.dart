import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/cards/cart_card.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';
import 'order_summary_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  bool isCod = true;

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
                                onTap: (){
                                  setState(() {
                                    isCod == false? isCod = true: isCod = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isCod? primaryColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Text(
                                      "COD",
                                      style: TextStyle(
                                        color: isCod? lightColor: darkColor,
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
                                onTap: (){
                                  setState(() {
                                    isCod == true? isCod = false: isCod = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isCod? Colors.transparent: primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Text(
                                      "ONLINE PAY",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isCod ? darkColor: lightColor,
                                        fontSize: 14,
                                      ),
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
            12.heightBox,
            const Expanded(
              child: Column(
                children: [Text("Nothing to show")],
              ),
            ),
            12.heightBox,
            CustomButton(
              btnText: "Pay Now",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
