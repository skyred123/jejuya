import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget for the bottom sheet header
class BottomSheetHeader extends StatelessWidget {
  /// Default constructor
  const BottomSheetHeader({
    super.key,
    this.title,
    this.actions,
    this.padding,
  });

  /// The title widget.
  final String? title;

  /// The list of actions.
  final List<Widget>? actions;

  /// The padding for the title widget.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.only(
            top: 15.hMin,
            left: 15.wMin,
            right: 15.wMin,
          ),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.spMin,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),

          const Spacer(),

          /// If the actions list is not null,
          /// map it to a list of widgets with right margins.
          ...actions ??
              [
                IconButton(
                  onPressed: nav.back<void>,
                  icon: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 25.rMin,
                    color: context.color.black,
                  ),
                ),
              ],
        ],
      ),
    );
  }
}
