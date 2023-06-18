import 'package:flutter/material.dart';
import 'package:teriyaki_bowl_app/utils/utils.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:velocity_x/velocity_x.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool isLoading = false;

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
                        "Forgot Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      12.heightBox,
                      CustomTextField(
                          controller: emailController, labelText: "Email"),
                      16.heightBox,
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : CustomButton(
                              btnText: "Submit",
                              onTap: () async {

                                setState(() {
                                  isLoading = true;
                                });

                                await AuthMethods().passwordReset(
                                    emailController.text, context).then((value) => showSnackBar("Email sent to your account", context));

                                setState(() {
                                  isLoading = false;
                                });

                              }),
                      8.heightBox
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
