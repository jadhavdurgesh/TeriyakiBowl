import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:teriyaki_bowl_app/views/forgot_password_screen.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:teriyaki_bowl_app/views/signup_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Get.offAll(() => const HomeScreen());
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      12.heightBox,
                      CustomTextField(
                          controller: emailController, labelText: "Email"),
                      12.heightBox,
                      CustomTextField(
                          controller: passwordController,
                          isPass: true,
                          labelText: "Password"),
                      12.heightBox,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ForgotPasswordScreen());
                        },
                        child: const Text(
                          "Forget Password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 16,
                              color: darkColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      16.heightBox,
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: loginUser,
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
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: lightColor,
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
                          Get.to(() => const SignupScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: darkColor,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: " Sign Up",
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
