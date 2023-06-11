import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/cards/cart_card.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          "Cart",
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
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: () {
                  Get.offAll(() => const HomeScreen());
                },
                icon: const Icon(
                  Icons.home_outlined,
                  size: 32,
                  color: primaryColor,
                )),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              ListView.builder(
                itemCount: 3,
                padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index){
                  return const CartCard();
                },
              ),
              72.heightBox,
            ],
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: CustomButton(
              btnText: "Checkout",
              onTap: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}
