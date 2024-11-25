import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Sign in page
class SignInController extends BaseController with UseCaseProvider {
  /// Default constructor for the SignInController.
  SignInController();

  // --- Member Variables ---

  /// Email Controller
  final TextEditingController emailController = TextEditingController();

  /// Password Controller
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  // --- Computed Variables ---
  // --- State Variables ---
  final isLoading = listenableStatus(false);
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---
  Future<void> login() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
      print(token);
      nav.toHome();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String errorMessage = '';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = tr("sign_in.user_not_found");
          break;
        case 'wrong-password':
          errorMessage = tr("sign_in.wrong_password");
          break;
        default:
          errorMessage = tr("sign_in.have_error");
          break;
      }
      nav.showSnackBar(message: errorMessage);
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
