import 'package:flutter/material.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String hint;
  final Color color;
  final double borderWidth;
  final double fontSize;

  const CustomTextField({
    super.key,
    required this.editingController,
    this.hint = "",
    required this.color,
    this.borderWidth = 1,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: borderWidth.rMin,
            ),
            borderRadius: BorderRadius.circular(20.rMin),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: borderWidth.rMin,
            ),
            borderRadius: BorderRadius.circular(20.rMin),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 20.hMin,
            horizontal: 16.wMin,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: fontSize,
          )),
      cursorColor: color,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
