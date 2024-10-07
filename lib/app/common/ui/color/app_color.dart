import 'package:flutter/material.dart';

/// An abstract class that defines the color scheme of the app.
abstract class AppColor {
  /// The primary background color.
  Color get primaryBackground;

  /// The accent color.
  Color get accentColor;

  /// The container background color.
  Color get containerBackground;

  /// The color of the snackbar.
  Color get snackBarColor;

  /// The text color.
  Color get textColor;

  /// The error text color.
  Color get errorTextColor;

  /// The subtext color.
  Color get subTextColor;

  /// The warning text color.
  Color get warningTextColor;

  /// The bottom sheet background color.
  Color get bottomSheetBackground;

  /// The tab bar label color.
  Color get tabBarLabelColor;

  /// The tab bar label selected color.
  Color get tabBarLabelSelectedColor;
}
