import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/language/language_supported.dart';
import 'package:jejuya/app/layers/presentation/components/pages/profile/profile_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/setting/setting_controller.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

/// Page widget for the profile feature
class ProfilePage extends StatelessWidget
    with ControllerProvider<ProfileController>, GlobalControllerProvider {
  /// Default constructor
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = globalController<SettingController>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Observer(
            builder: (context) {
              return Column(
                children: [
                  BouncesAnimatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      nav.toSignIn();
                    },
                    height: 100.hMin,
                    width: 100.hMin,
                    leading: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                  BouncesAnimatedButton(
                    onPressed: () {
                      ctrl.language.value = LanguageSupported.vietnamese;
                      html.window.location.reload();
                    },
                    height: 100.hMin,
                    width: 100.hMin,
                    leading: const Text(
                      "Vietnamese",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                  BouncesAnimatedButton(
                    onPressed: () {
                      ctrl.language.value = LanguageSupported.english;
                      html.window.location.reload();
                    },
                    height: 100.hMin,
                    width: 100.hMin,
                    leading: const Text(
                      "English",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                  BouncesAnimatedButton(
                    onPressed: () {
                      ctrl.language.value = LanguageSupported.korean;
                      html.window.location.reload();
                    },
                    height: 100.hMin,
                    width: 100.hMin,
                    leading: const Text(
                      "Korean",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
