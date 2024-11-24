import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';
import 'package:path/path.dart';

/// Controller for the Sign up page
class SignUpController extends BaseController with UseCaseProvider {
  /// Default constructor for the SignUpController.
  SignUpController();

  // --- Member Variables ---

  /// Email Controller
  final TextEditingController emailController = TextEditingController();

  /// Password Controller
  final TextEditingController passwordController = TextEditingController();

  /// Password Controller
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final auth = FirebaseAuth.instance;

  // --- Computed Variables ---
  // --- State Variables ---
  final isLoading = listenableStatus(false);
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  void signUp() async {
    try {
      isLoading.value = true;
      if (passwordController.value != confirmPasswordController.value) {
        nav.showSnackBar(message: 'Mật khẩu và xác nhận không trùng');
        isLoading.value = false;
        return;
      }
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      nav.showSnackBar(message: 'Đăng ký thành công');
      nav.toSignIn();
      print('User: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'email-already-in-use') {
        nav.showSnackBar(
          message: 'Email này đã tồn tại. Vui lòng thử một email khác.',
        );
      } else {
        nav.showSnackBar(message: 'Đã xảy ra lỗi: ${e.message}');
      }
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
