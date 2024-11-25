import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_in/sign_in_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_text_field.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:easy_localization/easy_localization.dart';

/// Page widget for the Sign in feature
class SignInPage extends StatelessWidget
    with ControllerProvider<SignInController> {
  /// Default constructor for the SignInPage.
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _body,
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo,
                _headerText,
                _signInInfo,
                _signInBtn,
                _signUpBtn,
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
                tr("sign_in.welcome_back"),
                style: TextStyle(
                  color: context.color.primaryColor,
                  fontSize: 33.spMin,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                tr("sign_in.sign_in"),
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
              _textField(ctrl.emailController, tr("sign_in.email"), false)
                  .paddingOnly(bottom: 16.hMin),
              _textField(ctrl.passwordController, tr("sign_in.password"), true),
            ],
          ).paddingOnly(top: 60.hMin);
        },
      );

  Widget _textField(
          TextEditingController controller, String hint, bool obscureText) =>
      Builder(builder: (context) {
        return CustomTextField(
          editingController: controller,
          color: context.color.primaryColor,
          hint: hint,
          fontSize: 16.spMin,
          obscureText: obscureText,
        );
      });

  Widget get _signInBtn => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Column(
            children: [
              BouncesAnimatedButton(
                onPressed: () => ctrl.login(),
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
                        tr("sign_in.sign_in"),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ).paddingOnly(top: 50.hMin),
              BouncesAnimatedButton(
                onPressed: () {},
                leading: Text(
                  tr("sign_in.forgot_password"),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.spMin,
                  ),
                ),
              ).paddingOnly(top: 5.hMin),
            ],
          );
        },
      );

  Widget get _signUpBtn => Builder(
        builder: (context) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr("sign_in.dont_have_account"),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.spMin,
                ),
              ),
              BouncesAnimatedButton(
                onPressed: () {
                  nav.toSignUp();
                },
                leading: Text(
                  tr("sign_in.sign_up"),
                  style: TextStyle(
                    color: context.color.primaryColor,
                    fontSize: 14.spMin,
                  ),
                ),
                height: 20.hMin,
                width: 70.wMin,
              ),
            ],
          ).paddingOnly(top: 10.hMin);
        },
      );
}
