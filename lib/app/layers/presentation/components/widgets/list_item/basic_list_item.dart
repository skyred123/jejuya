import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// The widget is a custom BasicList that can be used in the basic list.
class BasicListItem<T> extends StatelessWidget {
  /// Constructor for the widget.
  const BasicListItem({
    super.key,
    required this.item,
    this.onPressed,
    this.width,
    this.height,
    this.padding,
    this.onDismissed,
  });

  /// The [onPressed] callback, which receives the [item] when triggered.
  final void Function(T item)? onPressed;

  /// The [onDismissed] callback, which receives the [item] when triggered.
  final void Function(T item)? onDismissed;

  /// The [width] widget.
  final double? width;

  /// The [height] widget.
  final double? height;

  /// The [padding] widget.
  final EdgeInsets? padding;

  /// The [item] widget.
  final T item;

  @override
  Widget build(BuildContext context) {
    final paddingItem = padding ??
        EdgeInsets.symmetric(
          vertical: 10.hMin,
          horizontal: 15.wMin,
        );

    final decoration = BoxDecoration(
      color: context.color.containerBackground,
      borderRadius: BorderRadius.circular(16.rMin),
    );

    return Dismissible(
      onDismissed: (direction) => onDismissed?.call(item),
      key: Key((item as dynamic)!.id.toString()),
      child: BouncesAnimatedButton(
        onPressed: () => onPressed?.call(item),
        width: width,
        height: height,
        decoration: decoration,
        padding: paddingItem,
        alignment: Alignment.centerLeft,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              (item as dynamic)?.title as String,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.spMin,
              ),
            ),
            CustomText(
              (item as dynamic)?.body as String,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.spMin,
                color: context.color.black.withValues(alpha: 0.5),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ).marginOnly(bottom: 10.hMin).marginSymmetric(horizontal: 16.wMin),
    );
  }
}
