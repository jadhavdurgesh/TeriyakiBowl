import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 56,
            child: Image.asset("assets/user.png"),
          ),
          12.heightBox,
          const Text(
            "Amrit",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}
