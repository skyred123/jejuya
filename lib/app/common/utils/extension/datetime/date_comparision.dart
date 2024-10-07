/// Extension on [DateTime] to provide utility methods for date comparison.
extension DateComparisonExt on DateTime {
  /// Checks if the date is in the current month.
  bool get isInCurrentMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Checks if the date is today.
  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return isAtSameMomentAs(today);
  }

  /// Checks if the date is within the current week.
  bool get isThisWeek {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    return isAfter(firstDayOfWeek) || isAtSameMomentAs(firstDayOfWeek);
  }

  /// Checks if the date is within the current month.
  bool get isThisMonth {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month);
    return isAfter(firstDayOfMonth) || isAtSameMomentAs(firstDayOfMonth);
  }

  /// Checks if the date is within the previous month.
  bool get isLastMonth {
    final now = DateTime.now();
    final prevMonth = DateTime(now.year, now.month - 1);
    final lastDayOfPrevMonth = DateTime(now.year, now.month);
    return isAfter(prevMonth) && isBefore(lastDayOfPrevMonth);
  }
}
