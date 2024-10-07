import 'package:flutter/services.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';

/// Extension method to copy text to clipboard.
extension CopyToClipboardExt on String? {
  /// Copies the text to clipboard.
  Future<void> copyTextToClipboard() async {
    await Clipboard.setData(ClipboardData(text: this ?? ''));
    nav.showSnackBar(message: 'Copied to clipboard');
  }
}
