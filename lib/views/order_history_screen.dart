import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:teriyaki_bowl_app/views/cards/grid_card.dart';
import 'package:teriyaki_bowl_app/views/cards/list_card.dart';
import 'package:teriyaki_bowl_app/views/drawer/drawer_list.dart';
import 'package:teriyaki_bowl_app/views/item_detail_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import 'cards/order_card.dart';
import 'drawer/drawer_header.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SafeArea(
        child: Drawer(
          shape: RoundedRectangleBorder(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderDrawer(),
                DrawerList(),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        backgroundColor: backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: 32,
                color: primaryColor,
              ),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "Order History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: primaryColor,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
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

          var orderLength = snapshot.data!.docs[0]["orders"].length;

          return Column(
            children: [
              Expanded(
                child: orderLength != 0
                    ? ListView.builder(
                        itemCount: orderLength,
                        padding:
                            const EdgeInsets.all(12),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          var snap = snapshot.data!.docs[0];

                          var orderSnap = snap[snap['orders'][index]];

                          return OrderCard(orderSnap: orderSnap,);
                        },
                      )
                    : const Center(child: Text("Order Something!")),
              ),
            ],
          );
        },
      ),
    );
  }
}
