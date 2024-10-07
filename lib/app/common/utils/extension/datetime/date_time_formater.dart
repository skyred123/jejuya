import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

/// A utility class for formatting date and time.
class DateTimeFormater {
  static final Map<String, DateFormat> _cache = {};

  /// Returns a [DateFormat] object for formatting time
  /// in 24-hour format (e.g. "HH:mm").
  static DateFormat get formatTime24Hour => _fromCache('HH:mm');

  /// Returns a [DateFormat] object for formatting time
  /// in 12-hour format with AM/PM indicator (e.g. "h:mm a").
  static DateFormat get formattedTime12Hour => _fromCache('h:mm a');

  /// Returns a [DateFormat] object for formatting
  /// the month and day (e.g. "MMM d").
  static DateFormat get formatShortMonthDay => _fromCache('MMM d');

  /// Returns a [DateFormat] object for formatting
  /// the month, day, and time in 12-hour format (e.g. "MMM d h:mm a").
  static DateFormat get formatShortMonthDayTime12Hour =>
      _fromCache('MMM d h:mm a');

  /// Returns a [DateFormat] object for formatting the
  /// month, day, year, and time in 12-hour format (e.g. "MMM d, yyyy h:mm a").
  static DateFormat get formatShortMonthDayYearTime12Hour =>
      _fromCache('MMM d, yyyy h:mm a');

  /// Returns a [DateFormat] object for formatting
  /// the month, day, and year (e.g. "MMM d, yyyy").
  static DateFormat get formatShortMonthDayYear => _fromCache('MMM d, yyyy');

  static DateFormat _fromCache(String format, {Locale? forceLocale}) {
    if (_cache.containsKey(format)) {
      return _cache[format]!;
    }
    final locale = forceLocale ?? Get.context?.locale;
    if (locale != null) {
      final lang = '${locale.languageCode}${locale.countryCode != null ? '''
_${locale.countryCode}''' : '''
'''}';
      _cache[format] = DateFormat(
        format,
        lang,
      );
    } else {
      _cache[format] = DateFormat(format);
    }
    return _cache[format]!;
  }

  /// Invalidates the cache of date formats.
  ///
  /// If [reInit] is set to `true`, the cache will be re-initialized
  /// by re-creating all the date formats.
  static void invalidateCache({
    bool reInit = true,
    Locale? forceLocale,
  }) {
    final keys = _cache.keys.toList();
    _cache.clear();
    if (reInit) {
      for (final key in keys) {
        _fromCache(key, forceLocale: forceLocale);
      }
    }
  }
}
