// ignore_for_file: non_constant_identifier_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/profile_setting/profile_setting_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

/// Page widget for the profile feature
class ProfileSettingPage extends StatelessWidget
    with ControllerProvider<ProfileSettingController> {
  /// Default constructor
  ProfileSettingPage({super.key});

  List<Map<String, dynamic>> menuOptions = [
    {
      "icon": LocalSvgRes.setting,
      "title": "Tìm kiếm",
      "onTap": () {},
    },
  ];

  List<Map<String, dynamic>> menuAccount = [
    {
      "icon": LocalSvgRes.user,
      "title": "Tìm kiếm",
      "onTap": () {},
    },
    {
      "icon": LocalSvgRes.user,
      "title": "Thông tin",
      "onTap": () {
        print("Thông tin được chọn");
      },
    },
  ];

  List<Map<String, dynamic>> menuResource = [
    {
      "icon": LocalSvgRes.chat,
      "title": "Tìm kiếm",
      "onTap": () {},
    },
    {
      "icon": LocalSvgRes.chat,
      "title": "Thông tin",
      "onTap": () {
        print("Thông tin được chọn");
      },
    },
    {
      "icon": LocalSvgRes.logout,
      "title": "Thông tin",
      "onTap": () {
        print("Thông tin được chọn");
      },
    },
  ];

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
              SettingMenu(title: "Tùy chọn", list: menuOptions),
              SettingMenu(title: "Tài khoản", list: menuAccount),
              SettingMenu(title: "Tài nguyên", list: menuResource)
            ],
          ).paddingOnly(
            top: 20.wMin,
            bottom: 15.wMin,
            left: 20.wMin,
            right: 20.wMin,
          );
        },
      );
  Widget get _header => Builder(
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  "Cài đặt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
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

  Widget SettingMenu(
      {required String title, required List<Map<String, dynamic>> list}) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.spMin,
              color: context.color.black,
              fontWeight: FontWeight.w600,
            ),
          ).marginOnly(top: 36.hMin),
          Column(
              children: List.generate(list.length, (index) {
            final item = list[index];
            return SettingItem(
              title: item['title'],
              icon: item['icon'],
              onTap: item['onTap'],
            );
          })),
        ],
      );
    });
  }

  Widget SettingItem(
      {required String title,
      required String icon,
      required VoidCallback onTap}) {
    return Builder(builder: (context) {
      return BouncesAnimatedButton(
        onPressed: onTap,
        leading: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  context.color.black,
                  BlendMode.srcIn,
                ),
              ),
              Expanded(
                  child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.spMin,
                  color: context.color.black,
                ),
              )).paddingSymmetric(
                horizontal: 17.wMin,
                vertical: 15.hMin,
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black)
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: 1.wMin);
    });
  }
}
