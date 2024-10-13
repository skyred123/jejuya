import 'package:jejuya/app/common/ui/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';

/// A class that defines the dark theme colors for the app.
class DarkAppColor extends AppColor {
  @override
  Color get primaryBackground => '#FAFAFA'.toColor;

  @override
  Color get primaryColor => '#4B8B8B'.toColor;

  @override
  Color get accentColor => '#E0C0CC'.toColor;

  @override
  Color get containerBackground => '#747480'.toColor.withOpacity(0.12);

  @override
  Color get snackBarColor => '#55555555'.toColor;

  @override
  Color get textColor => '#FFFFFF'.toColor;

  @override
  Color get errorTextColor => '#FF5252'.toColor;

  @override
  Color get subTextColor => '#B3FFFFFF'.toColor;

  @override
  Color get warningTextColor => '#F4ADAD'.toColor;

  @override
  Color get bottomSheetBackground => '#2C2C2E'.toColor;

  @override
  Color get tabBarLabelColor => '#424242'.toColor;

  @override
  Color get tabBarLabelSelectedColor => '#FFFFFF'.toColor;
}
