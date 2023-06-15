import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:teriyaki_bowl_app/views/cards/grid_card.dart';
import 'package:teriyaki_bowl_app/views/cards/list_card.dart';
import 'package:teriyaki_bowl_app/views/drawer/drawer_list.dart';
import 'package:teriyaki_bowl_app/views/item_detail_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import 'drawer/drawer_header.dart';

class FavouriteListScreen extends StatefulWidget {
  const FavouriteListScreen({super.key});

  @override
  State<FavouriteListScreen> createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> {
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
          "Favourite List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [Container()],
        ),
      ),
    );
  }
}

class ListViewContent extends StatefulWidget {
  const ListViewContent({super.key});

  @override
  State<ListViewContent> createState() => _ListViewContentState();
}

class _ListViewContentState extends State<ListViewContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 8,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => const ItemDetailScreen());
            },
            child: const ListCard(),
          );
        },
      ),
    );
  }
}
