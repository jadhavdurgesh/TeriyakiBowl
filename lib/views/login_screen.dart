import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:teriyaki_bowl_app/views/forgot_password_screen.dart';
import 'package:teriyaki_bowl_app/views/home_screen.dart';
import 'package:teriyaki_bowl_app/views/signup_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                  color: lightColor,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Login",
                        textAlign: TextAlign.center ,
                        style: TextStyle(
                          fontSize: 24,
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      12.heightBox,
                      CustomTextField(controller: emailController, labelText: "Email"),
                      12.heightBox,
                      CustomTextField(controller: passwordController, labelText: "Password"),
                      12.heightBox,
                      GestureDetector(
                        onTap: (){
                          Get.to(() => const ForgotPasswordScreen());
                        },
                        child: const Text("Forget Password?",
                          textAlign: TextAlign.right ,
                          style: TextStyle(
                              fontSize: 16,
                              color: darkColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      16.heightBox,
                      CustomButton(btnText: "Login", onTap: (){
                        Get.offAll(() => const HomeScreen());
                      }),
                      20.heightBox,
                      GestureDetector(
                        onTap: (){
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
                                  fontWeight: FontWeight.bold
                              ),
                              children: [
                                TextSpan(
                                    text: " Sign Up",
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
