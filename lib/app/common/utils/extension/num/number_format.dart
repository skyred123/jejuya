import 'package:easy_localization/easy_localization.dart';

/// A class that contains predefined number formats.
class PredefinedNumberFormat {
  /// Formatter for double values with two decimal places & comma separators.
  static final doubleFormatter = NumberFormat('#,##0.00', 'en_US');

  /// Formatter for percentage values with two decimal places & percentage sign.
  static final percentageFormatter = NumberFormat('#0.##%', 'en_US');

  /// Formatter for total profit values with three decimal places.
  static final totalProfitFormatter = NumberFormat('###,###,###');

  /// Formatter for integer values which show at least 2 number.
  static final integerFormatter = NumberFormat('00', 'en_US');
}

/// An extension on the `num` class that provides formatted string
/// representations for numbers using the predefined number formats.
extension NumberFormatExt on num {
  /// Returns a string representation of the number formatted using the
  /// `PredefinedNumberFormat.doubleFormatter`.
  String get formattedNumber {
    return PredefinedNumberFormat.doubleFormatter.format(this);
  }

  /// Returns a string representation of the number formatted using the
  /// `PredefinedNumberFormat.percentageFormatter`.
  String get formattedPercentage {
    return PredefinedNumberFormat.percentageFormatter.format(this);
  }

  /// Returns a string representation of the number formatted using the
  /// `PredefinedNumberFormat.totalProfitFormatter`.
  String get formatTotalProfit {
    return PredefinedNumberFormat.totalProfitFormatter.format(this);
  }

  /// Formats a number with the specified minimum and maximum fraction digits.
  /// Returns the formatted number as a string.
  String formatNumber({
    int minimumFractionDigits = 0,
    int maximumFractionDigits = 4,
  }) {
    final formatter = NumberFormat()
      ..minimumFractionDigits = minimumFractionDigits
      ..maximumFractionDigits = maximumFractionDigits;
    return formatter.format(this);
  }

  /// Converts a number to a short string representation.
  String toShortString() {
    if (this >= 1000000000) {
      return '${(this / 1000000000).formatNumber(maximumFractionDigits: 1)}B';
    } else if (this >= 1000000) {
      return '${(this / 1000000).formatNumber(maximumFractionDigits: 1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).formatNumber(maximumFractionDigits: 1)}K';
    } else {
      return toString();
    }
  }
}

/// An extension on the `int` class that provides formatted string
/// representations for numbers using the predefined number formats.
extension IntegerFormatExt on num {
  /// Returns a string representation of the number formatted using the
  /// `PredefinedNumberFormat.integerFormatter`.
  String get formattedInt {
    return PredefinedNumberFormat.integerFormatter.format(this);
  }
}
