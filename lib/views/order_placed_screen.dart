import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teriyaki_bowl_app/views/cards/cart_card.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';
import 'order_summary_screen.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Order Placed",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: lightColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('assets/lottiesuccess.json', repeat: true, width: MediaQuery.of(context).size.width*0.7, height: MediaQuery.of(context).size.width*0.7),
                    28.heightBox,
                    const Text("Order Placed Successfully", textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      color: lightColor
                    ),),
                  ],
                ),
              ),
            ),
            12.heightBox,
            CustomButton(
              btnText: "Go to Home",
              backgroundColor: lightColor,
              textColor: primaryColor,
              onTap: () {
                Get.offAll(() => const HomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
