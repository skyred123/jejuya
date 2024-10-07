import 'package:easy_localization/easy_localization.dart';
import 'package:jejuya/app/common/utils/extension/datetime/date_time_formater.dart';

/// Extension method on DateTime to format it in a smart way
extension DateTimeExtension on DateTime {
  /// Format the date in a smart way.
  String get smartFormat {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final inputDate = DateTime(year, month, day);

    if (inputDate == today) {
      return '''
${tr('datetime.today')} ${DateTimeFormater.formattedTime12Hour.format(this)}''';
    } else if (inputDate == tomorrow) {
      return '''
${tr('datetime.tomorrow')}} ${DateTimeFormater.formattedTime12Hour.format(this)}''';
    } else if (year == now.year) {
      return DateTimeFormater.formatShortMonthDayTime12Hour.format(this);
    } else {
      return DateTimeFormater.formatShortMonthDayYearTime12Hour.format(this);
    }
  }

  /// Format the date in a smart way.
  String get shortDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final inputDate = DateTime(year, month, day);

    if (inputDate == today) {
      return tr('datetime.today');
    } else if (inputDate == yesterday) {
      return tr('datetime.yesterday');
    } else if (year == now.year) {
      return DateTimeFormater.formatShortMonthDay.format(this);
    } else {
      return DateTimeFormater.formatShortMonthDayYear.format(this);
    }
  }

  /// Format with the time in 12-hour format
  String get time12Hour => DateTimeFormater.formattedTime12Hour.format(this);

  /// Remaining time in hours & minutes
  /// If the difference is negative, return null
  /// If the difference is less than 1 hour, return the difference in minutes
  /// Otherwise, returning {hours}h {minutes}m
  String? get remainTime {
    final now = DateTime.now();
    final remainingDuration = difference(now);

    if (remainingDuration.isNegative) {
      return null;
    }

    if (remainingDuration.inHours < 1) {
      return '${remainingDuration.inMinutes}m';
    }

    return '''
${remainingDuration.inHours}h ${remainingDuration.inMinutes.remainder(60)}m''';
  }
}
