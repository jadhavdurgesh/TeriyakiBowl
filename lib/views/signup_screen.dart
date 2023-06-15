import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/resources/auth_methods.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';

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

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    mobileController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: emailController.text,
        fullName: fullNameController.text,
        mobile: mobileController.text,
        password: passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Get.offAll(() => const HomeScreen());
    }
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
                    color: lightColor, borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      12.heightBox,
                      CustomTextField(
                        controller: fullNameController,
                        labelText: "Full Name",
                      ),
                      12.heightBox,
                      CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Email",
                      ),
                      12.heightBox,
                      CustomTextField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          labelText: "Mobile Number"),
                      12.heightBox,
                      CustomTextField(
                          controller: passwordController,
                          isPass: true,
                          labelText: "Password"),
                      12.heightBox,
                      CustomTextField(
                          controller: confirmPasswordController,
                          isPass: true,
                          labelText: "Confirm Password"),
                      16.heightBox,
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if(passwordController.text.length < 6){
                              showSnackBar("Password should have more than 6 characters", context);
                            } else {
                              if(passwordController.text == confirmPasswordController.text){
                                signUpUser();
                              } else {
                                showSnackBar("Password doesn't match", context);
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: lightColor,
                                        ),
                                      )
                                    : const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.heightBox,
                      GestureDetector(
                        onTap: () {
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
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: " Login",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold))
                                ]),
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
