import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';

/// Controller for the Sign in page
class SignInController extends BaseController with UseCaseProvider {
  /// Default constructor for the SignInController.
  SignInController();

  // --- Member Variables ---

  /// Email Controller
  final TextEditingController emailController = TextEditingController();

  /// Password Controller
  final TextEditingController passwordController = TextEditingController();

  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  @override
  FutureOr<void> onDispose() async {}
}
