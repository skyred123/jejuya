import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Extension on [num] to provide convenient methods for getting the minimum
/// value of a number and the device screen width, height, and diagonal.
extension AdaptiveSizeExt on num {
  /// Returns the minimum value between the current number and
  /// the scaled value of the current number based on the device screen width.
  /// Should be used for width, horizontal margin, horizontal pading.
  double get wMin => min(toDouble(), w);

  /// Returns the minimum value between the current number and
  /// the scaled value of the current number based on the device screen height.
  /// Should be used for height, vertical margin, vertical pading.
  double get hMin => min(toDouble(), h);

  /// Returns the minimum value between the current number and
  /// the scaled value of the current adapt number
  /// according to the smaller of width or height
  /// Should be used for radius, circle icon size.
  double get rMin => min(toDouble(), r);
}
