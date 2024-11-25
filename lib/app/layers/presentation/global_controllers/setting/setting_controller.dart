import 'dart:async';

import 'package:jejuya/app/layers/data/sources/local/ls_key_predefined.dart';
import 'package:jejuya/app/layers/data/sources/local/model/language/language_supported.dart';
import 'package:jejuya/app/layers/data/sources/local/model/theme/theme_supported.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/obs_setting.dart';

/// Controller for the global setting state
class SettingController extends BaseController {
  /// SettingController constructor
  SettingController() {
    // ENABLE FOLLOWING LINES IF YOU WANT TO LISTENING SYSTEM THEME AND LANGUAGE
    // SchedulerBinding.instance.platformDispatcher
    //     .onPlatformBrightnessChanged = refreshTheme;
    // SchedulerBinding.instance.platformDispatcher.onLocaleChanged =
    //     refreshLocale;
    // refreshTheme();
  }

  /// The setting of current language
  final language = ObsSetting<LanguageSupported>(
    key: LSKeyPredefinedExt.language,
    initValue: LanguageSupported.korean,
  );

  /// The setting of current theme
  final theme = ObsSetting<ThemeSupported>(
    key: LSKeyPredefinedExt.theme,
    initValue: ThemeSupported.light,
  );

  @override
  FutureOr<void> onDispose() async {}
}
