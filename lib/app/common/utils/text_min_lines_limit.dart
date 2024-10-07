/// Extension on [String] to limit the number of lines in the string.
extension MininesLimitStringExtension on String {
  /// Returns the string with a minimum number of lines.
  ///
  /// [minLines] is the minimum number of lines to keep in the string.
  /// If the number of lines in the string is less than [minLines], the string
  /// will be padded with new lines to reach the minimum number of lines.
  ///
  /// Returns the string with a minimum number of lines.
  String minLinesLimit(int minLines, {bool force = true}) {
    if (force) {
      final lines = split('\n');
      if (lines.length < minLines) {
        final newLines = List<String>.filled(minLines - lines.length, '');
        return '$this\n${newLines.join('\n')}';
      }
    }
    // Hack to reduce extra code from the callers if force == false
    return this;
  }
}
