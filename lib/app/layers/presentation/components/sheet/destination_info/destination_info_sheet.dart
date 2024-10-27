import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:jejuya/app/common/ui/image/image_remote.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/destination_info/destination_info_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Sheet widget for the Destination info feature
class DestinationInfoSheet extends StatelessWidget
    with ControllerProvider<DestinationInfoController> {
  /// Default constructor for the DestinationInfoSheet.
  const DestinationInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final sheetHeight = 0.6 * MediaQuery.sizeOf(context).height;
    return Container(
      color: context.color.primaryBackground,
      height: sheetHeight,
      child: _body,
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _info),
                  _headerBtn,
                ],
              ).paddingOnly(top: 30.hMin, bottom: 40.hMin),
              _image,
              _seeMoreBtn
            ],
          );
        },
      ).paddingAll(20.rMin);

  Widget get _info => Builder(
        builder: (context) {
          final ctrl = controller(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${ctrl.location?.name}",
                style: TextStyle(
                  fontSize: 23.spMin,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingOnly(bottom: 20.hMin),
              _iconText(
                LocalSvgRes.desAddress,
                "${ctrl.location?.address}",
              ).paddingOnly(bottom: 20.hMin),
              _iconText(
                LocalSvgRes.desPhone,
                "${ctrl.location?.time}",
              ),
            ],
          );
        },
      );

  Widget get _headerBtn => Builder(
        builder: (context) {
          return Column(
            children: [
              BouncesAnimatedButton(
                width: 40.rMin,
                height: 40.rMin,
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    LocalSvgRes.like,
                    colorFilter: ColorFilter.mode(
                      context.color.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ).paddingSymmetric(vertical: 11.hMin, horizontal: 10.wMin),
                ),
              ).paddingOnly(bottom: 10.hMin),
              BouncesAnimatedButton(
                width: 45.rMin,
                height: 45.rMin,
                leading: Container(
                  decoration: BoxDecoration(
                    color: context.color.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    LocalSvgRes.schedule,
                    colorFilter: ColorFilter.mode(
                      context.color.white,
                      BlendMode.srcIn,
                    ),
                  ).paddingSymmetric(vertical: 11.hMin, horizontal: 10.wMin),
                ),
              ),
            ],
          );
        },
      );

  Widget _iconText(String image, String text) => Builder(
        builder: (context) {
          return Row(
            children: [
              SvgPicture.asset(
                image,
                colorFilter: ColorFilter.mode(
                  context.color.black,
                  BlendMode.srcIn,
                ),
              ).paddingOnly(right: 7.hMin),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.spMin,
                  color: context.color.black,
                ),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ],
          );
        },
      );

  Widget get _image => Builder(
        builder: (context) {
          return ImageNetwork(
            image: RemoteImageRes.background,
            height: context.height / 3.3,
            width: context.width,
            duration: 1500,
            curve: Curves.easeIn,
            fitWeb: BoxFitWeb.cover,
            onLoading: const CircularProgressIndicator(
              color: Colors.indigoAccent,
            ),
            onError: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(30.rMin),
          );
        },
      );

  Widget get _seeMoreBtn => Builder(
        builder: (context) {
          return BouncesAnimatedButton(
            leading: Text(
              "See More >",
              style: TextStyle(
                fontSize: 12.spMin,
              ),
            ),
          );
        },
      ).paddingOnly(top: 10.hMin);
}
