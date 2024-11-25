import 'dart:async';

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
  final TextEditingController emailController =
      TextEditingController(text: 'hiyan789@gmail.com');

  /// Password Controller
  final TextEditingController passwordController =
      TextEditingController(text: 'lethu0045');
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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print(await userCredential.user?.getIdToken());
      nav.toHome();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String errorMessage = '';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Không tìm thấy người dùng với email này.';
          break;
        case 'wrong-password':
          errorMessage = 'Mật khẩu không đúng.';
          break;
        default:
          errorMessage = 'Đã xảy ra lỗi. Vui lòng thử lại.';
          break;
      }
      nav.showSnackBar(message: errorMessage);
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
