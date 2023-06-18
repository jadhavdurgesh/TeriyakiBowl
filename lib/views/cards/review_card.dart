import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../common/custom_button.dart';

class ReviewCard extends StatefulWidget {
  final reviewSnap;
  const ReviewCard({super.key, required this.reviewSnap});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {

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
                  child: Text("Order Number: ${widget.reviewSnap['oid']}",
                    style: const TextStyle(
                        color: darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                8.widthBox,
                Text("${widget.reviewSnap['time']}",
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            8.heightBox,
            RatingBar.builder(
              initialRating: widget.reviewSnap['rating'],
              itemSize: 24,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              ignoreGestures: true,
              onRatingUpdate: (rating){
              },
            ),
            8.heightBox,
            Text( "${widget.reviewSnap['description']}",
              style: const TextStyle(
                  color: textDarkColor,
                  fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

