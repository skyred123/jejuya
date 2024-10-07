import 'dart:ui';

/// Extension to get the hex string from Color
extension ColorExtension on Color {
  /// Get the hex string from Color
  String get hexString =>
      '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
