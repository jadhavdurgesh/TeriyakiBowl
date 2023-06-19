import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:teriyaki_bowl_app/views/cards/grid_card.dart';
import 'package:teriyaki_bowl_app/views/cards/list_card.dart';
import 'package:teriyaki_bowl_app/views/cart_screen.dart';
import 'package:teriyaki_bowl_app/views/drawer/drawer_list.dart';
import 'package:teriyaki_bowl_app/views/item_detail_screen.dart';
import 'package:teriyaki_bowl_app/views/search_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/utils.dart';
import 'drawer/drawer_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData = {};
  var cartData = {};
  var totalCart = 0;
  var favourite = [];
  String name = "";
  bool isGrid = true;

  final List<String> categories = [
    'TERIYAKI',
    'BENTO',
    'Signature Rolls',
    'Sushi Rolls',
    'SIDES & SALAD',
    'BEVERAGES',
  ];

  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var cartSnap = await FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      cartData = cartSnap.data()!;
      userData = snap.data()!;
      setState(() {
        name = userData["full_name"];
        favourite = userData["favourite"];
        totalCart = cartData['items'].length;
      });
    } catch (e) {
    }
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
                HeaderDrawer(name: name),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Get.to(() => SearchScreen(cartData: cartData,));
              },
              icon: const Icon(
                Icons.search,
                size: 32,
                color: primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
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
      body: SafeArea(
        child: Column(
          children: [
            8.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Let's eat\nQuality Food",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid ? isGrid = false : isGrid = true;
                      });
                    },
                    icon: Icon(
                      isGrid ? Icons.grid_view_outlined : Icons.list_outlined,
                      color: primaryColor,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            12.heightBox,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    12.widthBox,
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColor,
                          borderRadius: BorderRadius.circular(8),
                          border: selectedCategory == 0 ? Border.all(color: primaryColor, width: 2) : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(0, 1),
                              blurRadius: 1,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Text("All Items"),
                      ),
                    ),
                    12.widthBox,
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColor,
                          border: selectedCategory == 1 ? Border.all(color: primaryColor, width: 2) : null,
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
                        padding: const EdgeInsets.all(12),
                        child: const Text("Teriyaki"),
                      ),
                    ),
                    8.widthBox,
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColor,
                          border: selectedCategory == 2 ? Border.all(color: primaryColor, width: 2) : null,
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
                        padding: const EdgeInsets.all(12),
                        child: const Text("Bento"),
                      ),
                    ),
                    12.widthBox,
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = 3;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColor,
                          border: selectedCategory == 3 ? Border.all(color: primaryColor, width: 2) : null,
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
                        padding: const EdgeInsets.all(12),
                        child: const Text("Signature Rolls"),
                      ),
                    ),
                    12.widthBox,
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = 4;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColor,
                          border: selectedCategory == 4 ? Border.all(color: primaryColor, width: 2) : null,
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
                        padding: const EdgeInsets.all(12),
                        child: const Text("Sushi Rolls"),
                      ),
                    ),
                    12.widthBox,
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = 5;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColor,
                          border: selectedCategory == 5 ? Border.all(color: primaryColor, width: 2) : null,
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
                        padding: const EdgeInsets.all(12),
                        child: const Text("Sides & Salads"),
                      ),
                    ),
                    12.widthBox,
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = 6;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColor,
                          border: selectedCategory == 6 ? Border.all(color: primaryColor, width: 2) : null,
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
                        padding: const EdgeInsets.all(12),
                        child: const Text("Beverages"),
                      ),
                    ),
                    12.widthBox,
                  ],
                ),
              ),
            ),
            // tabs
            12.heightBox,
            Builder(builder: (BuildContext context){
              if(selectedCategory == 0){
                return StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('items').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  },
                );
              }
              if(selectedCategory == 1){
                return StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('items').where('item_sub_category', isEqualTo: 'TERIYAKI').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  },
                );
              }
              if(selectedCategory == 2){
                return StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('items').where('item_sub_category', isEqualTo: 'BENTO').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  },
                );
              }
              if(selectedCategory == 3){
                return StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('items').where('item_sub_category', isEqualTo: 'Signature Rolls').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  },
                );
              }
              if(selectedCategory == 4){
                return StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('items').where('item_sub_category', isEqualTo: 'Sushi Rolls').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  },
                );
              }
              if(selectedCategory == 5){
                return StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('items').where('item_sub_category', isEqualTo: 'SIDES & SALAD').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  },
                );
              }
              if(selectedCategory == 6){
                return StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('items').where('item_sub_category', isEqualTo: 'BEVERAGES').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  },
                );
              }

              return StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  if(selectedCategory == 0){

                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );

                  } if(selectedCategory == 1){
                    return isGrid
                        ? GridViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    )
                        : ListViewContent(
                      snapshot: snapshot,
                      cartData: cartData,
                    );
                  }


                  return isGrid
                      ? GridViewContent(
                    snapshot: snapshot,
                    cartData: cartData,
                  )
                      : ListViewContent(
                    snapshot: snapshot,
                    cartData: cartData,
                  );
                },
              );

            }),
            // List: GridView or ListView
          ],
        ),
      ),
    );
  }
}

class GridViewContent extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final cartData;

  const GridViewContent(
      {super.key, required this.snapshot, required this.cartData});

  @override
  State<GridViewContent> createState() => _GridViewContentState();
}

class _GridViewContentState extends State<GridViewContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            childAspectRatio: 2 / 2.7,
            mainAxisSpacing: 12),
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
        itemCount: widget.snapshot.data!.docs.length,
        itemBuilder: (BuildContext context, index) {
          var snap = widget.snapshot.data!.docs[index].data();
          return GestureDetector(
            onTap: () {
              Get.to(() =>
                  ItemDetailScreen(
                    snap: snap,
                  ));
            },
            child: GridCard(snap: snap),
          );
        },
      ),
    );
  }
}

class ListViewContent extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final cartData;

  const ListViewContent(
      {super.key, required this.snapshot, required this.cartData});

  @override
  State<ListViewContent> createState() => _ListViewContentState();
}

class _ListViewContentState extends State<ListViewContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.snapshot.data!.docs.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() =>
                  ItemDetailScreen(
                    snap: widget.snapshot.data!.docs[index].data(),
                  ));
            },
            child: ListCard(
              snap: widget.snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
