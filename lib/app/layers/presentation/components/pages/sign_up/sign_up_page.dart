import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_up/sign_up_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_text_field.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Sign up feature
class SignUpPage extends StatelessWidget
    with ControllerProvider<SignUpController> {
  /// Default constructor for the SignUpPage.
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body,
      ),
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logo,
              _headerText,
              _signInInfo,
              _signInBtn,
              Expanded(child: _signUpBtn),
            ],
          ).paddingOnly(
            top: 70.hMin,
            right: 25.wMin,
            left: 25.wMin,
            bottom: 30.hMin,
          );
        },
      );
  Widget get _headerText => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bắt Đầu Hành Trình!",
                style: TextStyle(
                  color: context.color.primaryColor,
                  fontSize: 33.spMin,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Đăng Ký",
                style: TextStyle(
                  color: context.color.primaryColor,
                  fontSize: 33.spMin,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingOnly(top: 12.hMin),
            ],
          ).paddingOnly(top: 40.hMin);
        },
      );

  Widget get _logo => Builder(builder: (context) {
        return Center(
          child: SvgPicture.asset(
            LocalSvgRes.logo,
            height: 97.wMin,
            width: 108.5.hMin,
          ),
        );
      });

  Widget get _signInInfo => Builder(
        builder: (context) {
          final ctrl = controller(context);
          return Column(
            children: [
              _textField(ctrl.emailController, "Email")
                  .paddingOnly(bottom: 16.hMin),
              _textField(ctrl.passwordController, "Mật Khẩu")
                  .paddingOnly(bottom: 16.hMin),
              _textField(ctrl.passwordController, "Xác Nhận Mật Khẩu"),
            ],
          ).paddingOnly(top: 60.hMin);
        },
      );

  Widget _textField(TextEditingController controller, String hint) =>
      Builder(builder: (context) {
        return CustomTextField(
          editingController: controller,
          color: context.color.primaryColor,
          hint: hint,
          fontSize: 16.spMin,
        );
      });

  Widget get _signInBtn => Builder(
        builder: (context) {
          return Column(
            children: [
              BouncesAnimatedButton(
                onPressed: () {},
                decoration: BoxDecoration(
                  color: context.color.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                leading: const Text(
                  'Đăng Ký',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ).paddingOnly(top: 50.hMin),
            ],
          );
        },
      );

  Widget get _signUpBtn => Builder(builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đã có tài khoản?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.spMin,
              ),
            ),
            BouncesAnimatedButton(
              onPressed: () {},
              leading: Text(
                'Đăng Nhập',
                style: TextStyle(
                  color: context.color.primaryColor,
                  fontSize: 14.spMin,
                ),
              ),
              height: 20.hMin,
              width: 90.wMin,
            ),
          ],
        );
      });
}
