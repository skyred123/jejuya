import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';

/// Extension on [Widget] to add shimmer animation.
extension ShimmerAnimationExt on Widget {
  /// Adds shimmer animation to the widget.
  Widget get shimmerAnimation => Builder(
        builder: (context) {
          return animate(
            onPlay: (controller) => controller.repeat(), // Loop the animation
          ).shimmer(duration: 2000.ms, color: context.color.primaryBackground);
        },
      );
}
