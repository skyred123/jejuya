import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_up/sign_up_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_text_field.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Sign up feature
class SignUpPage extends StatelessWidget
    with ControllerProvider<SignUpController> {
  /// Default constructor for the SignUpPage.
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return SingleChildScrollView(
            // Bọc trong SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo,
                _headerText,
                _signInInfo,
                _signUpBtn,
                _signInBtn,
              ],
            ).paddingOnly(
              top: 30.hMin,
              right: 25.wMin,
              left: 25.wMin,
              bottom: 30.hMin,
            ),
          );
        },
      );

  Widget get _headerText => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("sign_up.start_your_journey"),
                style: TextStyle(
                  color: context.color.primaryColor,
                  fontSize: 33.spMin,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                tr("sign_up.sign_up"),
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

  Widget get _signInInfo => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Column(
            children: [
              _textField(ctrl.emailController, tr("sign_up.email"), false)
                  .paddingOnly(bottom: 16.hMin),
              _textField(ctrl.passwordController, tr("sign_up.password"), true)
                  .paddingOnly(bottom: 16.hMin),
              _textField(ctrl.confirmPasswordController,
                  tr("sign_up.confirm_password"), true),
            ],
          ).paddingOnly(top: 60.hMin);
        },
      );

  Widget _textField(
          TextEditingController controller, String hint, bool obscureText) =>
      Observer(
        builder: (context) {
          return CustomTextField(
            editingController: controller,
            color: context.color.primaryColor,
            hint: hint,
            fontSize: 16.spMin,
            obscureText: obscureText,
          );
        },
      );

  Widget get _signUpBtn => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Column(
            children: [
              BouncesAnimatedButton(
                onPressed: () => ctrl.signUp(),
                decoration: BoxDecoration(
                  color: context.color.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                leading: ctrl.isLoading.value == true
                    ? SizedBox(
                        width: 20.rMin,
                        height: 20.rMin,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.color.white,
                          ),
                          strokeWidth: 2.0,
                        ),
                      )
                    : Text(
                        tr("sign_up.sign_up"),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ).paddingOnly(top: 50.hMin),
            ],
          );
        },
      );

  Widget get _signInBtn => Builder(
        builder: (context) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr("sign_up.already_have_account"),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.spMin,
                ),
              ),
              BouncesAnimatedButton(
                onPressed: () {
                  nav.toSignIn();
                },
                leading: Text(
                  tr("sign_up.sign_in"),
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
        },
      ).paddingOnly(top: 15.hMin);
}
