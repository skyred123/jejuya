import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/container/container_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

/// Action item for the sheet
class BottomSheetActionItem extends StatelessWidget {
  /// Default constructor for the SheetActionItem.
  const BottomSheetActionItem({
    required this.icon,
    required this.title,
    super.key,
    this.onPressed,
  });

  /// Icon for the action item
  final IconData icon;

  /// Title for the action item
  final String title;

  /// Callback for the action item
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ContainerWrapper(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        vertical: 10.hMin,
      ),
      child: Row(
        children: [
          Icon(icon, size: 22.spMin, color: context.color.black).marginOnly(
            right: 10.wMin,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.spMin,
              color: context.color.black,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
