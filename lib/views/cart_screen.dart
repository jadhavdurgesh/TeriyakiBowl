import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/resources/firestore_methods.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';
import 'order_summary_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  var taxData = {};
  var orderData = {};
  double tax = 0.00;
  int totalOrders = 0;

  getData() async {
    try {
      var commonSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('tax')
          .get();

      var orderSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('orders')
          .get();

      taxData = commonSnap.data()!;
      orderData = orderSnap.data()!;

      setState(() {
        tax = commonSnap['tax'].toDouble();
        totalOrders = orderData['totalOrders'];
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            var cartLength = snapshot.data!.docs[0]["items"].length;

            return Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: cartLength != 0
                          ? ListView.builder(
                              itemCount: snapshot.data!.docs[0]["items"].length,
                              padding: const EdgeInsets.only(
                                  top: 12, right: 12, left: 12),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                var snap = snapshot.data!.docs[0];

                                var itemSnap = snap[snap['items'][index]];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
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
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: SizedBox(
                                              height: 92,
                                              child: AspectRatio(
                                                aspectRatio: 1 / 1,
                                                child: CachedNetworkImage(
                                                  key: UniqueKey(),
                                                  imageUrl:
                                                      itemSnap['item_image'],
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "${itemSnap['item_name']}"
                                                              .allWordsCapitilize(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                Dialog(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    color:
                                                                        lightColor),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(16),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    const Text(
                                                                      "Teriyaki Bowl",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            28,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    12.heightBox,
                                                                    const Text(
                                                                      "Are you sure delete cart item?",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    16.heightBox,
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        CustomButton(
                                                                          btnText:
                                                                              "Yes",
                                                                          onTap:
                                                                              () async {
                                                                            double
                                                                                cartAmount =
                                                                                snap['cart_amount'] - itemSnap['total_price'];

                                                                            await FirestoreMethods().deleteCart(
                                                                                iid: itemSnap['iid'],
                                                                                context: context,
                                                                                cartAmount: cartAmount);

                                                                            setState(() {});
                                                                            Get.back();
                                                                          },
                                                                        ),
                                                                        16.widthBox,
                                                                        CustomButton(
                                                                          btnText:
                                                                              "No",
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete_outline,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                12.heightBox,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () async {
                                                          int quantity = itemSnap[
                                                                  'quantity'] -
                                                              1;
                                                          double totalPrice = quantity
                                                                  .toDouble() *
                                                              itemSnap[
                                                                  'item_price'];
                                                          double cartAmount = snap[
                                                                  'cart_amount'] -
                                                              itemSnap[
                                                                  'item_price'];

                                                          if (itemSnap[
                                                                  'quantity'] >
                                                              1) {
                                                            await FirestoreMethods()
                                                                .updateToCart(
                                                              cartAmount:
                                                                  cartAmount,
                                                              iid: itemSnap[
                                                                  'iid'],
                                                              itemName: itemSnap[
                                                                  'item_name'],
                                                              quantity:
                                                                  quantity,
                                                              itemPrice: itemSnap[
                                                                  'item_price'],
                                                              totalPrice:
                                                                  totalPrice,
                                                              itemImage: itemSnap[
                                                                  'item_image'],
                                                              context: context,
                                                            );

                                                            setState(() {});
                                                          } else {
                                                            await FirestoreMethods()
                                                                .deleteCart(
                                                                    cartAmount:
                                                                        cartAmount,
                                                                    iid: itemSnap[
                                                                        'iid'],
                                                                    context:
                                                                        context);

                                                            setState(() {});
                                                          }
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${itemSnap['quantity']}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () async {
                                                          int quantity = itemSnap[
                                                                  'quantity'] +
                                                              1;
                                                          double totalPrice = quantity
                                                                  .toDouble() *
                                                              itemSnap[
                                                                  'item_price'];
                                                          double cartAmount = snap[
                                                                  'cart_amount'] +
                                                              itemSnap[
                                                                  'item_price'];

                                                          await FirestoreMethods()
                                                              .updateToCart(
                                                            cartAmount:
                                                                cartAmount,
                                                            iid:
                                                                itemSnap['iid'],
                                                            itemName: itemSnap[
                                                                'item_name'],
                                                            quantity: quantity,
                                                            itemPrice: itemSnap[
                                                                'item_price'],
                                                            totalPrice:
                                                                totalPrice,
                                                            itemImage: itemSnap[
                                                                'item_image'],
                                                            context: context,
                                                          );

                                                          setState(() {});
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .add_circle_outline,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "\$${itemSnap['item_price']}",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text("Add something in your cart!")),
                    ),
                    72.heightBox,
                  ],
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: cartLength == 0
                      ? CustomButton(
                          btnText: "Checkout",
                          isDisabled: true,
                          onTap: () {},
                        )
                      : isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor))
                          : CustomButton(
                              btnText: "Checkout",
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await getData();
                                setState(() {
                                  isLoading = false;
                                });
                                Get.to(() => OrderSummaryScreen(
                                      snap: snapshot.data!.docs[0],
                                      tax: tax,
                                  totalOrder: totalOrders,
                                    ));
                              },
                            ),
                ),
              ],
            );
          }),
    );
  }
}
