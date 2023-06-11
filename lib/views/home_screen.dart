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

import 'drawer/drawer_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Get.to(() => const SearchScreen());
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
            child: IconButton(
              onPressed: () {
                Get.to(() => const CartScreen());
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 32,
                color: primaryColor,
              ),
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
            // tabs
            12.heightBox,
            // List: GridView or ListView
            isGrid ? const GridViewContent() : const ListViewContent(),
          ],
        ),
      ),
    );
  }
}

class GridViewContent extends StatefulWidget {
  const GridViewContent({super.key});

  @override
  State<GridViewContent> createState() => _GridViewContentState();
}

class _GridViewContentState extends State<GridViewContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            childAspectRatio: 2 / 2.54,
            mainAxisSpacing: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 8,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => const ItemDetailScreen());
            },
            child: const GridCard(),
          );
        },
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
