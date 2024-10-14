import 'package:jejuya/app/common/ui/font/font.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The Text widget is a custom text that can be used in the app.
class CustomText extends StatelessWidget {
  /// Constructor for the CustomText widget.
  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.enableGlow = false,
  });

  /// The text widget.
  final String text;

  /// The text style widget.
  final TextStyle? style;

  /// The TextAlign.
  final TextAlign? textAlign;

  /// The TextOverflow.
  final TextOverflow? overflow;

  /// The max lines widget.
  final int? maxLines;

  /// The soft wrap widget.
  final bool? softWrap;

  /// Enable glow effect.
  final bool enableGlow;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: 16.spMin,
      color: context.color.black,
      fontFamily: Font.poppins,
      shadows: enableGlow
          ? [
              Shadow(
                blurRadius: 5.0.spMin,
                color: context.color.black,
              ),
            ]
          : null,
    );

    return Text(
      text,
      maxLines: maxLines,
      softWrap: softWrap,
      textAlign: textAlign,
      overflow: overflow,
      style: defaultStyle.merge(style),
    );
  }
}
