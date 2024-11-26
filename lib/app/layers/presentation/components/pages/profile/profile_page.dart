import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:jejuya/app/common/ui/image/image_remote.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/profile/profile_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';

/// Page widget for the profile feature
class ProfilePage extends StatelessWidget
    with ControllerProvider<ProfileController> {
  /// Default constructor
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return Column(
            children: [
              _header,
              _info,
              _seperate,
              _navList,
              _list,
            ],
          );
        },
      );

  Widget get _seperate => Builder(builder: (context) {
        return Container(
          width: double.infinity,
          height: 11.hMin,
          color: context.color.containerBackground,
        );
      }).paddingSymmetric(
        vertical: 18.hMin,
      );

  Widget get _navList => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Row(
            children: [
              GestureDetector(
                onTap: () => ctrl.isDetination.value = true,
                child: Container(
                  decoration: BoxDecoration(
                    color: ctrl.isDetination.value
                        ? context.color.primaryColor
                        : context.color.white,
                    borderRadius: BorderRadius.circular(50.rMin),
                    border: Border.all(color: context.color.primaryColor),
                  ),
                  child: Text(
                    tr("profile.last_visited"),
                    style: TextStyle(
                      fontSize: 12.spMin,
                      color: !ctrl.isDetination.value
                          ? context.color.primaryColor
                          : context.color.white,
                    ),
                  ).paddingSymmetric(horizontal: 20.wMin, vertical: 5.hMin),
                ),
              ).paddingOnly(right: 10.wMin),
              GestureDetector(
                onTap: () => ctrl.isDetination.value = false,
                child: Container(
                  decoration: BoxDecoration(
                    color: !ctrl.isDetination.value
                        ? context.color.primaryColor
                        : context.color.white,
                    borderRadius: BorderRadius.circular(50.rMin),
                    border: Border.all(color: context.color.primaryColor),
                  ),
                  child: Text(
                    tr("profile.last_reservation"),
                    style: TextStyle(
                      fontSize: 12.spMin,
                      color: ctrl.isDetination.value
                          ? context.color.primaryColor
                          : context.color.white,
                    ),
                  ).paddingSymmetric(horizontal: 20.wMin, vertical: 5.hMin),
                ),
              ),
            ],
          );
        },
      )
          .paddingOnly(
            bottom: 15.hMin,
          )
          .paddingSymmetric(
            horizontal: 25.wMin,
          );

  Widget get _header => Builder(
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  "Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              BouncesAnimatedButton(
                onPressed: () {
                  nav.toProfileSetting();
                },
                width: 30.rMin,
                height: 30.rMin,
                leading: SvgPicture.asset(
                  LocalSvgRes.setting,
                  colorFilter: ColorFilter.mode(
                    context.color.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          )
              .paddingSymmetric(
                horizontal: 20.wMin,
              )
              .marginOnly(
                top: 30.hMin,
              );
        },
      );
  Widget get _ava => Builder(
        builder: (context) {
          return ImageNetwork(
            image: RemoteImageRes.background,
            height: 106.rMin,
            width: 106.rMin,
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
            borderRadius: BorderRadius.circular(50.rMin),
          );
        },
      );
  Widget get _info => Builder(
        builder: (context) {
          return Row(
            children: [
              _ava.paddingOnly(right: 20.wMin),
              Container(
                decoration: BoxDecoration(
                  color: context.color.primaryLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20.rMin),
                ),
                child: Row(
                  children: [
                    _infoItem(tr("profile.favorited"), "10")
                        .paddingOnly(right: 10.wMin),
                    Container(
                      color: Colors.black,
                      width: 1.wMin,
                      height: 40.hMin,
                    ).paddingOnly(right: 20.wMin),
                    _infoItem(tr("profile.visited"), "10"),
                  ],
                ).paddingOnly(
                  top: 8.hMin,
                  bottom: 8.hMin,
                  left: 16.wMin,
                  right: 30.rMin,
                ),
              ),
            ],
          );
        },
      ).paddingSymmetric(
        horizontal: 25.wMin,
        vertical: 12.hMin,
      );
  Widget _infoItem(String name, String quantity) => Builder(
        builder: (context) {
          return Column(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 14.spMin),
              ).paddingOnly(bottom: 5.hMin),
              Text(
                quantity,
                style: TextStyle(fontSize: 14.spMin),
              ),
            ],
          );
        },
      );

  Widget get _list => Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.wMin,
                mainAxisSpacing: 8,
                crossAxisSpacing: 6,
                childAspectRatio: 200 / (200 * 1.25),
              ),
              itemCount: 50,
              itemBuilder: (context, index) {
                return _listItem;
              },
            );
          },
        ).paddingSymmetric(
          horizontal: 25.wMin,
          vertical: 10.hMin,
        ),
      );

  Widget get _listItem => Builder(
        builder: (context) {
          return Stack(
            children: [
              ImageNetwork(
                image: RemoteImageRes.background,
                height: (200 * 1.25).hMin,
                width: 200.wMin,
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
                borderRadius: BorderRadius.circular(20.rMin),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.rMin),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nohyung Supermarket",
                    style: TextStyle(
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w400,
                      color: context.color.white,
                    ),
                  ).paddingOnly(bottom: 5.hMin),
                  _iconText(LocalSvgRes.address, "Jeju-si")
                      .paddingOnly(bottom: 5.hMin),
                  _iconText(LocalSvgRes.schedule, "31/12/2024"),
                ],
              ).paddingSymmetric(horizontal: 20.wMin, vertical: 15.hMin),
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
                  context.color.primaryColor,
                  BlendMode.srcIn,
                ),
                width: 15.rMin,
                height: 15.rMin,
              ).paddingOnly(right: 7.hMin),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12.spMin,
                  color: context.color.white,
                ),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ],
          );
        },
      );
}
