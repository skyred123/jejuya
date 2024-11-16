import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/dialog/dialog_type_enum.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key, required this.dialogType});

  final DialogTypeEnum dialogType;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.color.white2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _icon,
          _name,
          _title,
          _showAgain,
          _button,
        ],
      ).paddingSymmetric(
        vertical: 22.hMin,
        horizontal: 20.wMin,
      ),
    );
  }

  Widget get _icon => Builder(
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.dialogType != DialogTypeEnum.completed
                      ? '#FEE4E2'.toColor
                      : '#D1FADF'.toColor,
                  borderRadius: BorderRadius.circular(50.rMin),
                  border: Border.all(
                      width: 8.rMin,
                      color: widget.dialogType != DialogTypeEnum.completed
                          ? '#FEF3F2'.toColor
                          : '#ECFDF3'.toColor),
                ),
                child: SvgPicture.asset(
                  widget.dialogType.iconUrl,
                  width: 24.rMin,
                  height: 24.rMin,
                  colorFilter: ColorFilter.mode(
                    widget.dialogType != DialogTypeEnum.completed
                        ? context.color.red
                        : context.color.primaryColor,
                    BlendMode.srcIn,
                  ),
                ).paddingAll(8.rMin),
              ),
              BouncesAnimatedButton(
                onPressed: () => nav.back(),
                width: 30.rMin,
                height: 30.rMin,
                leading: Icon(
                  Icons.close,
                  color: context.color.black,
                  size: 30.hMin,
                ),
              ),
            ],
          );
        },
      );

  Widget get _name => Builder(
        builder: (context) {
          return Text(
            widget.dialogType.name,
            style: TextStyle(
              color: context.color.black,
              fontSize: 20.spMin,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ).paddingOnly(top: 16.hMin);

  Widget get _title => Builder(
        builder: (context) {
          return Text(
            widget.dialogType.title,
            style: TextStyle(
              color: context.color.black,
              fontSize: 14.spMin,
            ),
          );
        },
      ).paddingOnly(top: 10.hMin);

  Widget get _showAgain => Builder(
        builder: (context) {
          return widget.dialogType == DialogTypeEnum.warning ||
                  widget.dialogType == DialogTypeEnum.delete
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hành động này không thể hoàn tác.',
                      style: TextStyle(
                        color: context.color.black,
                        fontSize: 14.spMin,
                      ),
                    ),
                    Row(
                      children: [
                        BouncesAnimatedButton(
                          onPressed: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          width: 16.rMin,
                          height: 16.rMin,
                          leading: Container(
                            decoration: BoxDecoration(
                              color: isChecked
                                  ? context.color.primaryColor
                                  : context.color.primaryBackground,
                              borderRadius: BorderRadius.circular(4.rMin),
                              border: Border.all(
                                color: isChecked
                                    ? context.color.primaryColor
                                    : 'D0D5DD'.toColor,
                              ),
                            ),
                            child: isChecked
                                ? Icon(
                                    Icons.check,
                                    color: context.color.white2,
                                    size: 12.rMin,
                                  )
                                : null,
                          ),
                        ).paddingOnly(right: 10.wMin),
                        Text(
                          'Không hiện lại',
                          style: TextStyle(
                            color: context.color.black,
                            fontSize: 14.spMin,
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 20.hMin),
                  ],
                )
              : const SizedBox.shrink();
        },
      ).paddingOnly(top: 5.hMin);

  Widget get _button => Builder(
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop({
                      'confirmed': false,
                      'isChecked': isChecked,
                    }); // Confirm
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.color.primaryBackground,
                      borderRadius: BorderRadius.circular(10.rMin),
                      border: Border.all(
                        color: 'D0D5DD'.toColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Hủy',
                        style: TextStyle(
                          color: context.color.black,
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w600,
                        ),
                      ).paddingSymmetric(vertical: 15.hMin),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.wMin,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop({
                      'confirmed': true,
                      'isChecked': isChecked,
                    }); // Confirm
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.dialogType != DialogTypeEnum.delete
                          ? context.color.primaryColor
                          : context.color.red,
                      borderRadius: BorderRadius.circular(10.rMin),
                    ),
                    child: Center(
                      child: Text(
                        widget.dialogType != DialogTypeEnum.delete
                            ? 'Xác Nhận'
                            : 'Xóa',
                        style: TextStyle(
                          color: context.color.white2,
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w600,
                        ),
                      ).paddingSymmetric(vertical: 15.hMin),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ).paddingOnly(top: 16.hMin);
}
