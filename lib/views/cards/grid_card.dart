import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../resources/firestore_methods.dart';
import '../../utils/utils.dart';

class GridCard extends StatefulWidget {
  final snap;
  const GridCard({super.key, required this.snap,});

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  var userData = {};
  var favourite = [];
  var isFav = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });

  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      userData = snap.data()!;
      setState(() {
        favourite = userData["favourite"];
        isFav = favourite.contains(widget.snap['iid']);
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(2, 2),
                blurRadius: 2,
                spreadRadius: 2)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: widget.snap['item_image'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor.withOpacity(0.4)),
                    child: IconButton(
                      onPressed: () async {
                        await FirestoreMethods().makeFavourite(
                          userData['uid'],
                          widget.snap['iid'],
                          favourite
                        );
                        getData();
                      },
                      icon: isFav
                          ? const Icon(
                              Icons.favorite,
                              color: lightColor,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: lightColor,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Text(
                        "\$${widget.snap["item_price"]}",
                        style: const TextStyle(
                            color: lightColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            8.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "${widget.snap["item_name"]}".allWordsCapitilize(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            4.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "${widget.snap["item_sub_category"]}".allWordsCapitilize(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
