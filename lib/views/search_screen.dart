import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';

import '../utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

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
              fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor),
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
                suffixIcon: const Icon(Icons.search),
                controller: searchController,
                labelText: "Search",
              ),
            ),
            const Expanded(
              child: Center(
                child: Text("Nothing to search!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
