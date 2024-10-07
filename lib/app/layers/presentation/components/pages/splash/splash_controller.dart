import 'dart:async';

import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/app/app_controller.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:dio/dio.dart';
import 'package:jejuya/app/core_impl/exception/common_error.dart';

/// Controller for the splash page
class SplashController extends BaseController with GlobalControllerProvider {
  /// Default constructor for the SplashController.
  SplashController();

  /// Sync app state before navigating to the home page
  Future<void> syncAppState() async {
    await globalController<AppController>().fresh();
    handleLogin();
  }

  // --- Methods ---

  /// Handle Login
  Future<void> handleLogin() async {
    final appCtrl = globalController<AppController>();
    if (!appCtrl.isLoggedIn.value) {
      await nav.toHome();
    }
    () async {
      try {
        await appCtrl.login();
      } catch (e, s) {
        if (e is DioException &&
            e.response?.data is Map<String, dynamic> &&
            // ignore: avoid_dynamic_calls
            e.response?.data['error']['code'] == 'not_allowed') {
          nav.showSnackBar(error: CommonError.timeout);
          return;
        }

        log.error(
          '[InviteFrensCodeController] Login Failed',
          error: e,
          stackTrace: s,
        );

        nav.showSnackBar(error: e);
      }
    }();
  }

  @override
  FutureOr<void> onDispose() async {}
}
