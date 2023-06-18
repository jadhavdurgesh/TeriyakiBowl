import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HeaderDrawer extends StatefulWidget {
  final String name;
  const HeaderDrawer({super.key, required this.name});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 56,
                child: Image.asset("assets/user.png"),
              ),
              12.heightBox,
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
