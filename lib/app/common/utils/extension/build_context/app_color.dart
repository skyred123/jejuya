import 'package:flutter/material.dart';
import 'package:jejuya/app/common/ui/color/app_color.dart';
import 'package:jejuya/app/common/utils/extension/theme/custom_theme.dart';

/// An ext for `BuildContext` that provides access to the app's color scheme.
extension AppColorExt on BuildContext {
  /// The app's color scheme.
  AppColor get color => appThemeExt(this).appColor;
}
