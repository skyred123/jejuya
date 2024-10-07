import 'package:jejuya/app/common/ui/theme/theme.dart';
import 'package:jejuya/core/reactive/obs_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

/// Enum representing the supported themes in the application.
enum ThemeSupported {
  /// System theme option.
  followSystem(title: 'setting.theme.options.follow_system'),

  /// Light theme option.
  light(title: 'setting.theme.options.light'),

  /// Dark theme option.
  dark(title: 'setting.theme.options.dark'),
  ;

  const ThemeSupported({required this.title});

  /// The title of the supported theme.
  final String title;

  /// Theme data getter.
  ThemeData get themeData {
    switch (this) {
      case dark:
        return AppTheme.dark;
      case light:
        return AppTheme.light;
      case followSystem:
        return brightness == Brightness.dark ? AppTheme.dark : AppTheme.light;
    }
  }

  /// Theme mode getter.
  ThemeMode get themeMode {
    switch (this) {
      case dark:
        return ThemeMode.dark;
      case light:
        return ThemeMode.light;
      case followSystem:
        return ThemeMode.system;
    }
  }

  /// Brightness getter.
  Brightness get brightness {
    switch (this) {
      case dark:
        return Brightness.dark;
      case light:
        return Brightness.light;
      case followSystem:
        return SchedulerBinding.instance.platformDispatcher.platformBrightness;
    }
  }
}

/// Setting value converter.
class ThemeSupportedConverter
    extends SettingValueConverter<ThemeSupported, String> {
  /// Default constructor for the [ThemeSupportedConverter].
  const ThemeSupportedConverter();

  @override
  ThemeSupported? fromStorableValue(String? storableValue) {
    return ThemeSupported.values.firstWhereOrNull(
      (e) => e.name == storableValue,
    );
  }

  @override
  String? toStorableValue(ThemeSupported? dynamicValue) {
    return dynamicValue?.name;
  }
}
