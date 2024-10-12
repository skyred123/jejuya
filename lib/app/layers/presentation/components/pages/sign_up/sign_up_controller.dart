import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';

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
  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  @override
  FutureOr<void> onDispose() async {}
}
