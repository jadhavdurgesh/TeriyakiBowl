import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/resources/auth_methods.dart';
import 'package:teriyaki_bowl_app/views/favourite_list_screen.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:teriyaki_bowl_app/views/order_history_screen.dart';
import 'package:teriyaki_bowl_app/views/rating_screen.dart';
import 'package:teriyaki_bowl_app/views/setting_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/colors.dart';
import '../common/custom_button.dart';
import '../login_screen.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Divider(height: 8,),
          ListTile(
            onTap: (){
              Get.offAll(() => const HomeScreen());
            },
            leading: const Icon(
              Icons.home_outlined,
              color: primaryColor,
              size: 28,
            ),
            title: const Text("Home"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: darkColor,
              size: 28,
            ),
          ),
          const Divider(height: 8,),
          ListTile(
            onTap: (){
              Get.offAll(() => const OrderHistoryScreen());
            },
            leading: const Icon(
              Icons.menu_book_outlined,
              color: primaryColor,
              size: 28,
            ),
            title: const Text("Order History"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: darkColor,
              size: 28,
            ),
          ),
          const Divider(height: 8,),
          ListTile(
            onTap: (){
              Get.offAll(() => const FavouriteListScreen());
              },
            leading: const Icon(
              Icons.favorite_border_outlined,
              color: primaryColor,
              size: 28,
            ),
            title: const Text("Favorite List"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: darkColor,
              size: 28,
            ),
          ),
          const Divider(height: 8,),
          ListTile(
            onTap: (){
              Get.offAll(() => const RatingScreen());
            },
            leading: const Icon(
              Icons.star_rate_outlined,
              color: primaryColor,
              size: 28,
            ),
            title: const Text("Rating"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: darkColor,
              size: 28,
            ),
          ),
          const Divider(height: 8,),
          ListTile(
            onTap: (){
              Get.offAll(() => const SettingScreen());
            },
            leading: const Icon(
              Icons.settings_outlined,
              color: primaryColor,
              size: 28,
            ),
            title: const Text("Setting"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: darkColor,
              size: 28,
            ),
          ),
          const Divider(height: 8,),
          ListTile(
            onTap: (){
              showDialog(
                context: context,
                builder: (ctx) => Dialog(
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
                          "Are you sure to logout from this app?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        16.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              btnText: "Logout",
                              onTap: () async {
                                Get.back();
                                await AuthMethods().signOut(context);
                              },
                            ),
                            16.widthBox,
                            CustomButton(
                              btnText: "Cancel",
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.logout_outlined,
              color: primaryColor,
              size: 28,
            ),
            title: const Text("Logout"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: darkColor,
              size: 28,
            ),
          ),
          const Divider(height: 8,),
        ],
      ),
    );
  }
}
