import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController editingController;
  final String hint;
  final Color color;
  final double borderWidth;
  final double fontSize;
  final String prefixIcon; // Path for left-side SVG icon
  final String suffixIcon; // Path for right-side SVG icon
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    required this.editingController,
    this.hint = "",
    required this.color,
    this.borderWidth = 1,
    required this.fontSize,
    this.prefixIcon = "",
    this.suffixIcon = "",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.color.containerBackground,
            width: borderWidth.rMin,
          ),
          borderRadius: BorderRadius.circular(15.rMin),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.color.containerBackground,
            width: borderWidth.rMin,
          ),
          borderRadius: BorderRadius.circular(15.rMin),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.wMin,
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: fontSize,
        ),
        filled: true,
        fillColor: context.color.containerBackground,
        prefixIcon: prefixIcon.isNotEmpty
            ? SvgPicture.asset(
                prefixIcon,
                height: 15.rMin,
                width: 15.rMin,
              ).paddingAll(10.rMin)
            : null,
        suffixIcon: suffixIcon.isNotEmpty
            ? SvgPicture.asset(
                suffixIcon,
                height: 15.rMin,
                width: 15.rMin,
              ).paddingAll(10.rMin)
            : null,
      ),
      cursorColor: color,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
