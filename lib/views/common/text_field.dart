import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLines;
  final Widget? suffixIcon;
  final bool isPass;
  final TextInputType keyboardType;
  final bool readOnly;
  final Color borderColor;

  const CustomTextField({super.key,
    required this.controller,
    required this.labelText,
    this.maxLines = 1,
    this.suffixIcon,
    this.readOnly = false,
    this.isPass = false,
    this.borderColor = darkColor,
    this.keyboardType = TextInputType.text
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: textDarkColor,
            fontWeight: FontWeight.bold
          ),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder()
      ),
    );
  }
}
