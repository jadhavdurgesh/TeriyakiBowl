import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:velocity_x/velocity_x.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  var userData = {};
  bool isLoading = false;
  String email = "";
  String password = "";


  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();

    getData();
  }


  getData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = snap.data()!;
      setState(() {
        email = userData['email'];
        password = userData['password'];
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
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
          "Change Password",
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 12, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.heightBox,
                    const Text(
                      "Old Password",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: oldPasswordController,
                      labelText: "Enter your old password",
                      isPass: true,
                    ),
                    16.heightBox,
                    const Text(
                      "New Password",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: newPasswordController,
                      labelText: "Enter your new password",
                      isPass: true,
                    ),
                    16.heightBox,
                    const Text(
                      "Confirm Password",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: confirmPasswordController,
                      labelText: "Enter your confirm password",
                      isPass: true,
                    ),
                    24.heightBox
                  ],
                ),
              ),
            ),
            isLoading ? const Center(child: CircularProgressIndicator(color: primaryColor,),) : CustomButton(
              btnText: "Submit",
              onTap: () async {

                setState(() {
                  isLoading = true;
                });

                if(newPasswordController.text == confirmPasswordController.text){
                  if(newPasswordController.text.length >= 6){

                    await AuthMethods().changeAuthPassword(
                        email: email,
                        password: oldPasswordController.text,
                        newPassword: newPasswordController.text,
                        context: context
                    ).then((value) {

                      setState(() {
                        isLoading = false;
                      });

                      Get.back();
                    });

                    setState(() {
                      isLoading = false;
                    });

                  } else {

                    setState(() {
                      isLoading = false;
                    });

                    showSnackBar("Password should contain at least 6 characters", context);
                  }
                }
                else {

                  setState(() {
                    isLoading = false;
                  });

                  showSnackBar("New password doesn't match with confirm password", context);
                }

                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
