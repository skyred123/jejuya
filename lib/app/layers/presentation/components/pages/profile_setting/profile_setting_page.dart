// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/language/language_supported.dart';
import 'package:jejuya/app/layers/presentation/components/pages/profile_setting/profile_setting_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/setting/setting_controller.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

/// Page widget for the profile feature
class ProfileSettingPage extends StatelessWidget
    with
        ControllerProvider<ProfileSettingController>,
        GlobalControllerProvider {
  /// Default constructor
  ProfileSettingPage({super.key});

  List<Map<String, dynamic>> menuOptions = [
    {
      "icon": LocalSvgRes.localize,
      "title": tr("setting.languages"),
      "onTap": () {},
    },
  ];

  List<Map<String, dynamic>> menuAccount = [
    {
      "icon": LocalSvgRes.user,
      "title": tr("setting.change_password"),
      "onTap": () {},
    },
    {
      "icon": LocalSvgRes.user,
      "title": tr("setting.change_infomation"),
      "onTap": () {
        print("Thông tin được chọn");
      },
    },
  ];

  List<Map<String, dynamic>> menuResource = [
    {
      "icon": LocalSvgRes.chat,
      "title": tr("setting.contact_support"),
      "onTap": () {},
    },
    {
      "icon": LocalSvgRes.chat,
      "title": tr("setting.terms_services"),
      "onTap": () {
        print("Thông tin được chọn");
      },
    },
    {
      "icon": LocalSvgRes.logout,
      "title": tr("setting.sign_out"),
      "onTap": () {
        FirebaseAuth.instance.signOut();
        nav.toSignIn();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header,
              Text(
                tr("setting.preferences"),
                style: TextStyle(
                  fontSize: 14.spMin,
                  color: context.color.black,
                  fontWeight: FontWeight.w600,
                ),
              ).marginOnly(top: 36.hMin),
              languageBtn,
              SettingMenu(title: tr("setting.account"), list: menuAccount),
              SettingMenu(title: tr("setting.sign_out"), list: menuResource)
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
              BouncesAnimatedButton(
                height: 20.rMin,
                width: 20.rMin,
                onPressed: () => nav.toHome(),
                leading: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Text(
                  tr("setting.title"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ).paddingSymmetric(
            horizontal: 20.wMin,
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
        height: 60.hMin,
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

  Widget get languageBtn => Builder(
        builder: (context) {
          final settingCtrl = globalController<SettingController>();
          return BouncesAnimatedButton(
            height: 60.hMin,
            onPressed: () {
              showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  List<String> languages = ["English", "Vietnamese", "Korean"];
                  String selectedLanguage = "English";
                  String tempSelectedLanguage = selectedLanguage;
                  return AlertDialog(
                    title: Text(tr("setting.languages")),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return DropdownButton<String>(
                          value: tempSelectedLanguage,
                          onChanged: (String? newValue) {
                            setState(() {
                              tempSelectedLanguage = newValue!;
                            });
                          },
                          items: languages
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          nav.back();
                        },
                        child: Text(tr("setting.cancel")),
                      ),
                      TextButton(
                        onPressed: () {
                          selectedLanguage = tempSelectedLanguage;
                          if (selectedLanguage == "English") {
                            settingCtrl.language.value =
                                LanguageSupported.english;
                          }
                          if (selectedLanguage == "Vietnamese") {
                            settingCtrl.language.value =
                                LanguageSupported.vietnamese;
                          }
                          if (selectedLanguage == "Korean") {
                            settingCtrl.language.value =
                                LanguageSupported.korean;
                          }
                          html.window.location.reload();
                        },
                        child: Text(tr("setting.ok")),
                      ),
                    ],
                  );
                },
              );
            },
            leading: DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    LocalSvgRes.localize,
                    colorFilter: ColorFilter.mode(
                      context.color.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    tr("setting.languages"),
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
                  const Icon(Icons.arrow_forward_ios,
                      size: 20, color: Colors.black)
                ],
              ),
            ),
          ).paddingSymmetric(horizontal: 1.wMin);
        },
      );
}
