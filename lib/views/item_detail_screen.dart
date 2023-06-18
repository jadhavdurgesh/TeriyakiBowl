import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:teriyaki_bowl_app/resources/firestore_methods.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';
import 'cart_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  final snap;
  const ItemDetailScreen({super.key, required this.snap});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  var cartData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {

      var cartSnap = await FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      cartData = cartSnap.data()!;
      setState(() {
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "${widget.snap["item_name"]}".allWordsCapitilize(),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor),
        ),
        centerTitle: true,
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
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const CartScreen());
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 32,
                    color: primaryColor,
                  ),
                ),
                const Positioned(
                  top: 4,
                  right: 4,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: widget.snap['item_image'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
                12.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
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
                        ]),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.snap["item_name"]}"
                                    .allWordsCapitilize(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              "\$${widget.snap["item_price"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.snap["item_sub_category"]}"
                                    .allWordsCapitilize(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: textDarkColor,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.access_time,
                              color: primaryColor,
                            ),
                            4.widthBox,
                            Text(
                              "${widget.snap["prep_time"]} mnt",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // details
                8.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
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
                        ]),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Detail & Ingredients",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        8.heightBox,
                        Text(
                          "${widget.snap["item_description"]}"
                              .allWordsCapitilize(),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                72.heightBox,
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(
                    btnText: "Add to Cart",
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });

                      double cartAmount = cartData["cart_amount"] + widget.snap["item_price"];

                      await FirestoreMethods().addToCart(
                          iid: widget.snap["iid"],
                          itemName: widget.snap["item_name"],
                          quantity: 1,
                          itemPrice: widget.snap["item_price"].toDouble(),
                          totalPrice: widget.snap["item_price"].toDouble(),
                          itemImage: widget.snap["item_image"],
                          context: context,
                        cartAmount: cartAmount,
                      );

                      setState(() {
                        isLoading = false;
                      });

                      showSnack();

                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showSnack() {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: lightColor),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Teriyaki Bowl",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              12.heightBox,
              const Text(
                "Item has been added to your cart.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              16.heightBox,
              CustomButton(
                btnText: "Ok",
                onTap: () {
                  Navigator.of(context).pop("OK");
                  Get.to(() => const CartScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
