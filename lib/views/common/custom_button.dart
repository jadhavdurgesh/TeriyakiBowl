import 'package:flutter/material.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';


class CustomButton extends StatelessWidget {

  final String btnText;
  final Function()? onTap;

  const CustomButton({Key? key, required this.btnText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                btnText,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}