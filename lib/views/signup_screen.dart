import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    mobileController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  "assets/logov1.png",
                  height: 160,
                  width: 160,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Sign Up",
                        textAlign: TextAlign.center ,
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      12.heightBox,
                      CustomTextField(controller: fullNameController, labelText: "Full Name"),
                      12.heightBox,
                      CustomTextField(controller: emailController, labelText: "Email"),
                      12.heightBox,
                      CustomTextField(controller: mobileController, labelText: "Mobile Number"),
                      12.heightBox,
                      CustomTextField(controller: passwordController, labelText: "Password"),
                      12.heightBox,
                      CustomTextField(controller: confirmPasswordController, labelText: "Confirm Password"),
                      16.heightBox,
                      CustomButton(btnText: "Sign Up", onTap: (){}),
                      20.heightBox,
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                text: "Already have an account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: darkColor,
                                    fontWeight: FontWeight.bold
                                ),
                                children: [
                                  TextSpan(
                                      text: " Login",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
