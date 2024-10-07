import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';

/// Loading overlay widget with progress circular
class LoadingOverlay extends StatelessWidget {
  /// Default constructor
  const LoadingOverlay({required this.loading, super.key});

  /// Indicate show or hide the overlay
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: LoadingAnimationWidget.twoRotatingArc(
          color: Colors.white,
          size: 50.rMin,
        ),
      ),
    ).animate().fade(
          begin:
              loading ? 0.0 : 1.0, // Start from fully transparent if not shown
          end: loading ? 1.0 : 0.0, // End at fully opaque if shown
        );
  }
}
