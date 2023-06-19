import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // change screen
  changeScreen() {

    var count = 1;

    var authState = FirebaseAuth.instance.authStateChanges();

    Future.delayed(const Duration(seconds: 2), () {
      authState.listen((User? user) async {
        if(user == null && mounted){
          Get.offAll(() => const LoginScreen());
          count++;
        } else {

          if(count == 1){
            Get.offAll(() => const HomeScreen());
          } else {
            Get.offAll(() => const LoginScreen());
          }
          
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
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
              const CircularProgressIndicator(
                color: darkColor,
              ),
              24.heightBox,
              const Text(
                "Powered by MITS",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              24.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
