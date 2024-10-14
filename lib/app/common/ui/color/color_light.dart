import 'package:jejuya/app/common/ui/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';

/// A class that defines the light color scheme for the app.
class LightAppColor extends AppColor {
  @override
  Color get primaryBackground => '#FAFAFA'.toColor;

  @override
  Color get primaryColor => '#4B8B8B'.toColor;

  @override
  Color get black => '#131314'.toColor;

  @override
  Color get info => '#B8BABE'.toColor;

  @override
  Color get white => '#FAFAFA'.toColor;

  @override
  Color get white2 => '#FFFFFF'.toColor;

  @override
  Color get containerBackground => '#F1F0F0'.toColor;

  @override
  Color get red => '#F03E31'.toColor;

  @override
  Color get darkRed => '#9C140A'.toColor;

  @override
  Color get primaryLight => '#A5C5C5'.toColor;
}
