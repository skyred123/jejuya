import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:jejuya/core/reactive/obs_setting.dart';

/// Enum representing the supported languages in the application.
enum LanguageSupported {
  /// Follow the system language.
  followSystem(
    languageCode: '-',
    countryCode: '-',
    title: 'setting.language.options.follow_system',
  ),

  /// English language option.
  english(
    languageCode: 'en',
    countryCode: 'US',
    title: 'setting.language.options.english',
  ),

  /// Vietnamese language option.
  vietnamese(
    languageCode: 'vi',
    countryCode: 'VN',
    title: 'setting.language.options.vietnamese',
  ),

  /// Korean language option.
  korean(
    languageCode: 'ko',
    countryCode: 'KR',
    title: 'setting.language.options.korean',
  );

  /// Constructs a new instance of [LanguageSupported].
  const LanguageSupported({
    required this.languageCode,
    required this.countryCode,
    required this.title,
  });

  /// The language code for the supported language.
  final String languageCode;

  /// The country code for the supported language.
  final String? countryCode;

  /// The title of the supported language.
  final String title;

  /// Returns the locale for the supported language.
  Locale? get locale {
    if (this == LanguageSupported.followSystem) return null;
    try {
      return Locale(languageCode, countryCode);
    } catch (_) {
      return null;
    }
  }

  /// Key getter.
  String get key =>
      '$languageCode${countryCode != null ? '_$countryCode' : ''}';
}

/// Setting value converter.
class LanguageSupportedConverter
    extends SettingValueConverter<LanguageSupported, String> {
  /// Default constructor for the [LanguageSupportedConverter].
  const LanguageSupportedConverter();

  @override
  LanguageSupported? fromStorableValue(String? storableValue) {
    return LanguageSupported.values.firstWhereOrNull(
      (e) => e.name == storableValue,
    );
  }

  @override
  String? toStorableValue(LanguageSupported? dynamicValue) {
    return dynamicValue?.name;
  }
}
