import 'package:flutter/material.dart';

/// Extension on [String] to convert hexadecimal color codes to [Color] objects.
extension StringToColorExt on String {
  /// Converts a hexadecimal color code to a [Color] object.
  ///
  /// If the hexadecimal color code is in the format "#RRGGBB",
  /// it will be converted to "#FFRRGGBB" format before conversion.
  ///
  /// Returns a [Color] object if the hexadecimal color code
  /// is in the format "#RRGGBBAA" or "#RRGGBB".
  /// Otherwise, returns null.
  /// Example: "#5A769D".toColor
  Color get toColor {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
    return '#FFFFFF'.toColor;
  }

  /// Returns true if the color is a light color, false otherwise.
  /// Example: "#5A769D".isLightColor
  bool get isLightColor {
    final brightness = ThemeData.estimateBrightnessForColor(toColor);
    return brightness == Brightness.light;
  }

  /// Returns a darker version of the color.
  ///
  /// The [percent] parameter specifies the amount of darkness.
  /// It should be a value between 1 and 100.
  ///
  /// Example:
  /// ```dart
  /// Color myColor = "#42A5F5";
  /// Color darkerColor = myColor.darken(20);
  /// ```
  Color darken([int percent = 10]) {
    if (percent < 1 || percent > 100) {
      throw ArgumentError('Percent must be between 1 and 100');
    }
    final f = 1 - percent / 100;
    return Color.fromARGB(
      toColor.alpha,
      (toColor.red * f).round(),
      (toColor.green * f).round(),
      (toColor.blue * f).round(),
    );
  }

  /// Returns a lighter version of the color.
  ///
  /// The [percent] parameter specifies the percentage of lightness.
  /// The value must be between 1 and 100 (inclusive).
  ///
  /// Example:
  /// ```dart
  /// final color = "#42A5F5";
  /// final lighterColor = color.lighten(20);
  /// ```
  /// This will return a color that is 20% lighter than the original color.
  Color lighten([int percent = 10]) {
    if (percent < 1 || percent > 100) {
      throw ArgumentError('Percent must be between 1 and 100');
    }
    final p = percent / 100;
    return Color.fromARGB(
      toColor.alpha,
      toColor.red + ((255 - toColor.red) * p).round(),
      toColor.green + ((255 - toColor.green) * p).round(),
      toColor.blue + ((255 - toColor.blue) * p).round(),
    );
  }
}
