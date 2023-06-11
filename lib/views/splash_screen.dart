import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> const LoginScreen()))
    );
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
              const CircularProgressIndicator(color: darkColor,),
              const SizedBox(height: 24,)
            ],
          ),
        ),
      ),
    );
  }
}
