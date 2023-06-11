import 'package:flutter/material.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:teriyaki_bowl_app/views/common/text_field.dart';
import 'package:velocity_x/velocity_x.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  "https://i.pinimg.com/736x/e3/46/35/e34635d7e861c21b9b9c8513ea0780c1.jpg",
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
                      const Text("Forgot Password",
                        textAlign: TextAlign.center ,
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      12.heightBox,
                      CustomTextField(controller: emailController, labelText: "Email"),
                      16.heightBox,
                      CustomButton(btnText: "Submit", onTap: (){}),
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
