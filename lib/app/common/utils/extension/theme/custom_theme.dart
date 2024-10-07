import 'package:flutter/material.dart';
import 'package:jejuya/app/common/ui/color/app_color.dart';
import 'package:jejuya/app/common/ui/theme/theme.dart';

/// An ext for `BuildContext` that provides access to the app's color scheme.
CustomThemeExt appThemeExt(BuildContext context) =>
    Theme.of(context).extension<CustomThemeExt>() ??
    CustomThemeExt(appColor: AppTheme.lightAppColor);

/// An extension of the `ThemeExtension` class that provides a custom theme
/// for the app.
class CustomThemeExt extends ThemeExtension<CustomThemeExt> {
  /// Creates a custom theme extension.
  const CustomThemeExt({
    required this.appColor,
  });

  /// The color scheme of the app.
  final AppColor appColor;

  @override
  CustomThemeExt copyWith({AppColor? appColor}) {
    return CustomThemeExt(
      appColor: appColor ?? AppTheme.lightAppColor,
    );
  }

  @override
  CustomThemeExt lerp(
    ThemeExtension<CustomThemeExt>? other,
    double t,
  ) {
    return this;
  }
}
