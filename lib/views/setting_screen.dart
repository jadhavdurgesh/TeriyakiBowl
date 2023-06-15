import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:teriyaki_bowl_app/views/change_password_screen.dart';
import 'package:teriyaki_bowl_app/views/drawer/drawer_list.dart';
import 'package:velocity_x/velocity_x.dart';

import 'drawer/drawer_header.dart';
import 'edit_profile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
          "Setting",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(() => const EditProfileScreen());
                },
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit,
                          color: primaryColor,
                        ),
                        12.widthBox,
                        const Expanded(
                          child: Text("Edit Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.heightBox,
              GestureDetector(
                onTap: (){
                  Get.to(() => const ChangePasswordScreen());
                },
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lock_open_sharp,
                          color: primaryColor,
                        ),
                        12.widthBox,
                        const Expanded(
                          child: Text("Change Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.heightBox,
              GestureDetector(
                onTap: (){

                },
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.privacy_tip_outlined,
                          color: primaryColor,
                        ),
                        12.widthBox,
                        const Expanded(
                          child: Text("Privacy Policy",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
