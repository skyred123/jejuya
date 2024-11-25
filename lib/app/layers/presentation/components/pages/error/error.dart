import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/ui/image/image_local.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:path/path.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return Column(
            children: [_header, _image, _text, _button],
          );
        },
      );

  Widget get _header => Builder(builder: (context) {
        return Center(
          child: Text(
            "OPP!!!",
            style: TextStyle(
              fontSize: 40.spMin,
              fontWeight: FontWeight.w700,
              //color: context.color.primaryColor,
            ),
          ),
        ).paddingOnly(top: 180.hMin);
      });

  Widget get _image => Builder(builder: (context) {
        return Image.asset(
          LocalImageRes.error,
        );
      });

  Widget get _text => Builder(builder: (context) {
        return Container(
          child: Text(
            "Có điều gì đó không đúng :<<",
            style: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.w500),
          ),
        ).paddingOnly(top: 42.hMin);
      });

  Widget get _button => Builder(builder: (context) {
        return BouncesAnimatedButton(
          leading: Container(
              padding: EdgeInsets.fromLTRB(81.wMin, 10.hMin, 81.wMin, 10.hMin),
              decoration: BoxDecoration(
                  color: context.color.primaryColor,
                  borderRadius: BorderRadius.circular(10.rMin)),
              child: Text(
                "home",
                style: TextStyle(color: context.color.white),
              )),
          onPressed: () => nav.toHome(),
        ).paddingOnly(top: 21.hMin, left: 55.wMin, right: 55.wMin);
      });
}
