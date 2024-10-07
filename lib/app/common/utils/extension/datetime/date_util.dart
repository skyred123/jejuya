/// [DateUtilExt] extension on [DateTime] provides utility methods 
/// for date manipulation.
extension DateUtilExt on DateTime {
  /// Returns the start of the day.
  DateTime get startOfDay => DateTime(year, month, day);
}
