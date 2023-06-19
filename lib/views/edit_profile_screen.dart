import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:teriyaki_bowl_app/resources/auth_methods.dart';
import 'package:teriyaki_bowl_app/utils/utils.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var userData = {};

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    mobileController.dispose();
  }

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
      userData = snap.data()!;
      setState(() {
        emailController.text = userData["email"];
        usernameController.text = userData["full_name"];
        mobileController.text = userData["mobile"];
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              child: Image.asset("assets/user.png"),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: primaryColor,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.heightBox,
                      const Text(
                        "Email Address (cannot be changed)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: emailController,
                        labelText: "",
                        isDisabled: true,
                        hintText: "Enter your email address",
                        textColor: darkColor,
                        fontWeight: FontWeight.normal,
                      ),
                      16.heightBox,
                      const Text(
                        "Full Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: usernameController,
                        labelText: "",
                        hintText: "Enter your username",
                        textColor: darkColor,
                        fontWeight: FontWeight.normal,
                      ),
                      16.heightBox,
                      const Text(
                        "Mobile Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: mobileController,
                        labelText: "",
                        hintText: "Enter your mobile number",
                        textColor: darkColor,
                        fontWeight: FontWeight.normal,
                      ),
                      24.heightBox
                    ],
                  )),
                ),
              ),
              isLoading ? const Center(child: CircularProgressIndicator(color: primaryColor,),): CustomButton(
                btnText: "Update",
                onTap: () async {

                  setState(() {
                    isLoading = true;
                  });

                  await AuthMethods().updateUserInfo(
                    fullName: usernameController.text,
                    mobile: mobileController.text,
                    context: context,
                  );

                  showingSnackBar();

                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showingSnackBar() {
    showSnackBar("Profile Updated Successfully!", context);
  }
}
