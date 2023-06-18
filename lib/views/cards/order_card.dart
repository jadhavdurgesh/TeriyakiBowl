import 'package:flutter/material.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../common/custom_button.dart';

class OrderCard extends StatefulWidget {
  final orderSnap;
  const OrderCard({super.key, required this.orderSnap});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("Order Number: ${widget.orderSnap['oid']}",
                    style: const TextStyle(
                      color: darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                8.widthBox,
                Text("\$${(widget.orderSnap['order_total']).toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            8.heightBox,
            Text(widget.orderSnap['is_cod'] ? "Payment Method: COD" : "Payment Method: Online",
              style: const TextStyle(
                  color: darkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            4.heightBox,
            const Divider(),
            4.heightBox,
            Row(
              children: [
                const Expanded(
                  child: Text("Items ordered",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(),
              ],
            ),
            8.heightBox,
            ListView.builder(
              itemCount: widget.orderSnap['cart']['items'].length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index){

                var itemSnap = widget.orderSnap['cart'][widget.orderSnap['cart']['items'][index]];

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text("${itemSnap['item_name']} - ${itemSnap['quantity']} nos".allWordsCapitilize(),
                            style: const TextStyle(
                                color: darkColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        8.widthBox,
                        Text("\$${itemSnap['total_price'].toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    8.heightBox,
                  ],
                );
              },
            ),
            const Divider(),
            4.heightBox,
            Row(
              children: [
                const Text("Payment Status:",
                  style: TextStyle(
                      color: darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                8.widthBox,
                Text(widget.orderSnap['payment_completed'] ? "Paid" : "Unpaid",
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            8.heightBox,
            Row(
              children: [
                const Text("Order Status:",
                  style: TextStyle(
                      color: darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                8.widthBox,
                Text(widget.orderSnap['order_status'] == 1 ? "Order Received": "Order Not Received",
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            8.heightBox,
            Text("Date: ${widget.orderSnap['order_time']}",
              style: const TextStyle(
                  color: textDarkColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}

