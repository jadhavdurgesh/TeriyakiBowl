import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/resources/firestore_methods.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:teriyaki_bowl_app/views/drawer/drawer_list.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/utils.dart';
import 'cards/review_card.dart';
import 'common/custom_button.dart';
import 'drawer/drawer_header.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  TextEditingController reviewController = TextEditingController();
  double rating = 1.0;
  bool isLoading = false;

  var userData = {};
  String name = "";

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snap.data()!;
      setState(() {
        name = userData["full_name"];
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          shape: const RoundedRectangleBorder(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderDrawer(name: name,),
                const DrawerList(),
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
          "Rating",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .where("uid",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          );
                        }

                        var orderLength =
                            snapshot.data!.docs[0]["unreviewed"].length;

                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: lightColor),
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
                                  "Select the order that you want to review?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                12.heightBox,
                                orderLength == 0
                                    ? const Text(
                                        "You have no orders left to review!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: primaryColor))
                                    : ListView.builder(
                                        itemCount: orderLength,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var oid = snapshot.data!.docs[0]
                                              ["unreviewed"][index];

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();

                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) => Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: lightColor),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Text(
                                                              "Write a review",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            8.heightBox,
                                                            const Divider(),
                                                            8.heightBox,
                                                            RatingBar.builder(
                                                              initialRating:
                                                                  3.0,
                                                              minRating: 1,
                                                              itemBuilder: (context,
                                                                      _) =>
                                                                  const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                setState(() {
                                                                  this.rating =
                                                                      rating;
                                                                });
                                                              },
                                                            ),
                                                            12.heightBox,
                                                            TextField(
                                                              controller:
                                                                  reviewController,
                                                              maxLines: 3,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      "Type your description",
                                                                  hintStyle: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  border:
                                                                      OutlineInputBorder()),
                                                            ),
                                                            12.heightBox,
                                                            isLoading
                                                                ? const Center(
                                                                    child: CircularProgressIndicator(
                                                                        color:
                                                                            primaryColor))
                                                                : CustomButton(
                                                                    btnText:
                                                                        "Submit",
                                                                    onTap:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            true;
                                                                      });

                                                                      DateTime
                                                                          now =
                                                                          DateTime
                                                                              .now();
                                                                      String
                                                                          formattedDate =
                                                                          DateFormat('dd/MM/yy kk:mm:ss')
                                                                              .format(now);

                                                                      await FirestoreMethods().saveReview(
                                                                          oid:
                                                                              oid,
                                                                          description: reviewController
                                                                              .text,
                                                                          rating:
                                                                              rating,
                                                                          context:
                                                                              context,
                                                                          reviewTime:
                                                                              formattedDate);

                                                                      setState(
                                                                          () {
                                                                        rating =
                                                                            1.0;
                                                                        reviewController.text =
                                                                            "";
                                                                        isLoading =
                                                                            false;
                                                                      });

                                                                      Get.back();
                                                                    },
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                                  decoration: BoxDecoration(
                                                    color: lightColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade200,
                                                        offset:
                                                            const Offset(0, 1),
                                                        blurRadius: 1,
                                                        spreadRadius: 2,
                                                      )
                                                    ],
                                                  ),
                                                  child: Text(
                                                    "Order Number: $oid",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              12.heightBox,
                                            ],
                                          );
                                        },
                                      ),
                                12.heightBox,
                                CustomButton(
                                  btnText: "Go Back",
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
              icon: const Icon(
                Icons.add_box_rounded,
                size: 32,
                color: primaryColor,
              ),
            ),
          ),
        ],
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

            var reviewLength = snapshot.data!.docs[0]["reviews"].length;


            return ListView.builder(
              itemCount: reviewLength,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (BuildContext context, index) {

                var reviewSnap = snapshot.data!.docs[0]["reviews"][index];

                return GestureDetector(
                  onTap: () {},
                  child: ReviewCard(reviewSnap: reviewSnap,),
                );
              },
            );
          }),
    );
  }
}
