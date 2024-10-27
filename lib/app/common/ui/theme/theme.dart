import 'package:flutter/material.dart';
import 'package:jejuya/app/common/ui/color/color_dark.dart';
import 'package:jejuya/app/common/ui/color/color_light.dart';
import 'package:jejuya/app/common/ui/font/font.dart';
import 'package:jejuya/app/common/utils/extension/theme/custom_theme.dart';

/// A class that defines the app theme.
class AppTheme {
  /// The dark theme colors for the app.
  static final darkAppColor = DarkAppColor();

  /// The light theme colors for the app.
  static final lightAppColor = LightAppColor();

  /// The dark theme for the app.
  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkAppColor.primaryBackground,
    textTheme: Typography().white.apply(
          fontFamily: Font.poppins,
        ),
    extensions: [CustomThemeExt(appColor: darkAppColor)],
  );

  /// The light theme for the app.
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightAppColor.primaryBackground,
    textTheme: Typography().black.apply(
          fontFamily: Font.poppins,
        ),
    extensions: [CustomThemeExt(appColor: lightAppColor)],
    primaryColor: const Color(0xFFFAFAFA),
  );
}
