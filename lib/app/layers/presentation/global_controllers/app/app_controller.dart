import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/ls_key_predefined.dart';
import 'package:jejuya/app/layers/domain/usecases/user/login_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/user/logout_usecase.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';
import 'package:dio/dio.dart';

/// Controller for the global app state
class AppController extends BaseController
    with GlobalControllerProvider, UseCaseProvider {
  /// AppController constructor
  AppController();

  // --- Computed Variables ---

  /// Initial route
  String get initialRoute {
    return checkLoginStatus() ? PredefinedRoute.home : PredefinedRoute.signIn;
  }

  // --- State Variables ---

  /// User locals
  final user = listenableSetting(null, key: LSKeyPredefinedExt.user);

  /// Is user fresh (pull latest data from server)
  final isFreshedUser = listenable<bool>(false);

  // --- State Computed ---

  /// Is user logged in
  /// Logged in state means the user is authenticated with BE successfully
  /// & also completed the onboarding setup.
  late final isLoggedIn = listenableComputed(
    () => user.value != null,
  );

  // --- Usecases ---

  late final _loginUseCase = usecase<LoginUseCase>();
  late final _logoutUseCase = usecase<LogoutUseCase>();

  // --- Methods ---

  /// Fresh the global app state
  Future<void> fresh() async {}

  /// Handle Login
  Future<void> login() async {
    final response = await _loginUseCase.execute(LoginRequest());
    // freshUser(response.user);
  }

  /// Initialize the app state
  @override
  Future<void> initialize() async {
    try {
      await login();
    } catch (e, s) {
      if (e is DioException &&
          e.response?.data is Map<String, dynamic> &&
          e.response?.data['error']['code'] == 'not_allowed') {
        await _logoutUseCase.execute(LogoutRequest());
        return;
      }

      log.error(
        '[AppController] Login Failed',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  /// Fresh app user
  // void freshUser(User latestUser) {
  //   user.value = latestUser;
  //   isFreshedUser.value = true;
  // }

  bool checkLoginStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      log.info("Login at email: ${user.email}");
      return true;
    }
    return false;
  }

  @override
  FutureOr<void> onDispose() async {}
}
