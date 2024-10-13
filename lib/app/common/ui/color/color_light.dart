import 'package:jejuya/app/common/ui/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';

/// A class that defines the light color scheme for the app.
class LightAppColor extends AppColor {
  @override
  Color get primaryBackground =>
      const Color(0xFFE8F6F1); // const Color(0xFFE4DED5)

  @override
  Color get primaryColor => '#4B8B8B'.toColor;

  @override
  Color get accentColor => '#008080'.toColor;

  @override
  Color get containerBackground => Colors.black.withOpacity(0.04);

  @override
  Color get snackBarColor => '#55555555'.toColor;

  @override
  Color get subTextColor => '#666666'.toColor;

  @override
  Color get warningTextColor => '#F4ADAD'.toColor;

  @override
  Color get errorTextColor => '#8B0000'.toColor;

  @override
  Color get textColor => '#333333'.toColor;

  @override
  Color get bottomSheetBackground => '#2C2C2E'.toColor;

  @override
  Color get tabBarLabelColor => '#424242'.toColor;

  @override
  Color get tabBarLabelSelectedColor => '#FFFFFF'.toColor;
}
