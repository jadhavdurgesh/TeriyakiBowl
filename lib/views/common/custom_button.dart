import 'package:flutter/material.dart';
import 'package:teriyaki_bowl_app/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final Function()? onTap;
  final double paddingH;
  final double paddingV;

  const CustomButton({
    Key? key,
    required this.btnText,
    required this.onTap,
    this.paddingH = 24,
    this.paddingV = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: paddingV, horizontal: paddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                btnText,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
