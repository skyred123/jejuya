import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Middleware to ensure that the user is authenticated.
class EnsureAuthMiddleware extends GetMiddleware
    with UseCaseProvider, GlobalControllerProvider {
  @override
  RouteSettings? redirect(String? route) {
    // if (!globalController<AppController>().isLoggedIn.value) {
    //   return EnsureNotAuthedMiddleware().redirect(route);
    // }

    return null;
  }
}

/// Middleware to ensure that the user is not authenticated.
class EnsureNotAuthedMiddleware extends GetMiddleware
    with UseCaseProvider, GlobalControllerProvider {
  @override
  RouteSettings? redirect(String? route) {
    // if (globalController<AppController>().isLoggedIn.value) {
    //   return route != PredefinedRoute.home
    //       ? const RouteSettings(name: PredefinedRoute.home)
    //       : null;
    // }

    return null;
  }
}
