import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';

/// Extension for the GlobalKey to capture the widget as an image.
extension WidgetAsImageExtension on GlobalKey {
  /// This will create an image of the widget for which the global key used.
  Future<Uint8List?> captureWidget({
    double pixelRatio = 10,
  }) async {
    final complete = Completer<Uint8List?>();
    try {
      if (currentContext == null) {
        return null;
      }
      final boundary =
          currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        complete.complete(null);
        return complete.future;
      }
      final image = await boundary.toImage(
        pixelRatio: pixelRatio,
      );
      final bytes = await image.toByteData();
      if (bytes == null) {
        complete.complete(null);
        return complete.future;
      }
      ui.decodeImageFromPixels(Uint8List.view(bytes.buffer), image.width,
          image.height, ui.PixelFormat.rgba8888, (result) async {
        complete.complete(
          await result
              .toByteData(format: ui.ImageByteFormat.png)
              .then((value) => value?.buffer.asUint8List()),
        );
      });
      return complete.future;
    } catch (e, s) {
      log.error(
        '[WidgetAsImageExtension] Failed to capture the preview frame',
        error: e,
        stackTrace: s,
      );
      complete.complete(null);
      rethrow;
    }
  }
}
