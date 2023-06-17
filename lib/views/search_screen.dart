import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';

import '../utils/colors.dart';
import 'cards/list_card.dart';
import 'item_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final cartData;
  const SearchScreen({super.key, required this.cartData});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool isShowItem = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        title: const Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: primaryColor,
          ),
        ),
        backgroundColor: backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              size: 32,
              color: primaryColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: CustomTextField(
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    isShowItem = true;
                  });
                }, icon: const Icon(Icons.search),),
                controller: searchController,
                labelText: "Search",
              ),
            ),
            isShowItem ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('items')
                  .where(
                    'item_name',
                    isGreaterThanOrEqualTo: searchController.text.toUpperCase(),
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                    color: primaryColor,
                  )));
                }
                return ListViewContent(
                  snapshot: snapshot,
                  cartData: widget.cartData,
                );
              },
            ) : const Expanded(child: Center(child: Text("Search Something..."),)),
          ],
        ),
      ),
    );
  }
}

class ListViewContent extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final cartData;

  const ListViewContent({super.key, required this.snapshot, required this.cartData});

  @override
  State<ListViewContent> createState() => _ListViewContentState();
}

class _ListViewContentState extends State<ListViewContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: (widget.snapshot.data! as dynamic).docs.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => ItemDetailScreen(
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
