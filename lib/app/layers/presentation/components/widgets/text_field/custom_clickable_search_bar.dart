import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';

class CustomClickableSearchBar extends StatelessWidget {
  final TextEditingController editingController;
  final String hint;
  final Color color;
  final double fontSize;
  final String suffixIcon;
  final VoidCallback onSuffixIconTap;

  const CustomClickableSearchBar({
    super.key,
    required this.editingController,
    required this.hint,
    required this.color,
    required this.fontSize,
    required this.suffixIcon,
    required this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.wMin),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.rMin),
          borderSide: BorderSide(color: color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.rMin),
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.rMin),
          borderSide: BorderSide(color: color),
        ),
        suffixIcon: GestureDetector(
          onTap: onSuffixIconTap,
          child: SvgPicture.asset(
            suffixIcon,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ).paddingAll(12.rMin),
        ),
      ),
    );
  }
}
