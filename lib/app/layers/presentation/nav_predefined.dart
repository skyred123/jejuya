import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/home/home_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification/notification_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification/notification_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification_detail/notification_detail_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification_detail/notification_detail_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/profile/profile_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/core_impl/navigation/custom_get_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/home/home_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_in/sign_in_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_in/sign_in_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_up/sign_up_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_up/sign_up_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/splash/splash_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/splash/splash_page.dart';
import 'package:jejuya/core/arch/presentation/view/base_provider.dart';
import 'package:jejuya/core/navigation/navigator.dart' as navi;

/// The [Route] class defines the names of the routes used in the application.
class PredefinedRoute {
  /// Splash page route.
  static const String splash = '/';

  /// Splash page route.
  static const String signIn = '/sign_in';

  /// Splash page route.
  static const String signUp = '/sign_up';

  /// Home page route.
  static const String home = '/home';

  /// Profile page route.
  static const String profile = '/profile';

  /// Notification page route.
  static const String notification = '/notification';

  /// Notification detail page route.
  static const String notificationDetail = '/notification_detail?.*';
}

/// The [PredefinedPage] class defines the pages used in the application.
class PredefinedPage {
  /// List of all pages in the application.
  static final List<GetPage<dynamic>> allPages = [
    GetPageEnsureNotAuth(
      name: PredefinedRoute.splash,
      page: () => nav.splash,
    ),
    GetPageEnsureNotAuth(
      name: PredefinedRoute.signIn,
      page: () => nav.signIn,
    ),
    GetPageEnsureNotAuth(
      name: PredefinedRoute.signUp,
      page: () => nav.signUp,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.home,
      page: () => nav.home,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.profile,
      page: () => nav.profile,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.notification,
      page: () => nav.notification,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.notificationDetail,
      page: () {
        final id = num.parse(
            Uri.tryParse(Get.currentRoute)!.queryParameters['notication_id']!);
        return nav.notificationDetail(notificationId: id);
      },
    ),
  ];
}

/// This file contains extensions on the [navi.Navigator] class that define
/// predefined navigation routes and bottom sheets for the Bento mini app.
///
/// The [NavPredefined] extension defines methods for navigating to
/// specific pages such as the splash page, home page, onboarding
/// page, ...
extension NavPredefined on navi.Navigator {
  /// Splash page widget.
  Widget get splash => BaseProvider(
        ctrl: SplashController(),
        child: const SplashPage(),
      );

  /// Sign in page widget.
  Widget get signIn => BaseProvider(
        ctrl: SignInController(),
        child: const SignInPage(),
      );

  /// Sign in page widget.
  Widget get signUp => BaseProvider(
        ctrl: SignUpController(),
        child: const SignUpPage(),
      );

  /// Home page widget.
  Widget get home => BaseProvider(
        ctrl: HomeController(),
        child: HomePage(),
      );

  /// Profile page widget.
  Widget get profile => BaseProvider(
        ctrl: ProfileController(),
        child: const ProfilePage(),
      );

  /// Notification page widget.
  Widget get notification => BaseProvider(
        ctrl: NotificationController(),
        child: const NotificationPage(),
      );

  /// Notification detail page widget.
  Widget notificationDetail({required num? notificationId}) => BaseProvider(
        ctrl: NotificationDetailController(notificationId: notificationId),
        child: NotificationDetailPage(),
      );
}

/// The [ToPagePredefined] extension defines methods for navigating to
/// specific pages such as the writing page, ...
extension ToPagePredefined on navi.Navigator {
  /// Navigate to the splash page.
  Future<T?>? toSplash<T>() => toNamed(
        PredefinedRoute.splash,
      );

  Future<T?>? toSignIn<T>() => toNamed(
        PredefinedRoute.signIn,
      );

  Future<T?>? toSignUp<T>() => toNamed(
        PredefinedRoute.signUp,
      );

  /// Navigate to the home page.
  Future<T?>? toHome<T>() => toNamed(
        PredefinedRoute.home,
      );

  Future<T?>? toNotificationDetail<T>({required num? notificationId}) =>
      toNamed(
        PredefinedRoute.notificationDetail
            .replaceAll('.*', 'notication_id=$notificationId'),
        arguments: notificationId,
      );
}

/// The [BottomSheetPredefined] extension defines methods for showing bottom
/// sheets such as the bottom sheet for selecting a language, ...
extension BottomSheetPredefined on navi.Navigator {
  // /// Show main sheet
  // Future<T?>? showMainSheet<T>() => bottomSheet(
  //       mainSheet,
  //       routeName: 'sheet-main',
  //     );
}

/// The [DialogPredefined] extension defines methods for showing dialogs such
/// as the dialog for selecting a language, ...
extension DialogPredefined on navi.Navigator {
//  /// Show main dialog
//   Future<T?>? showMainSheet<T>() => dialog(
//         mainSheet,
//         routeName: 'sheet-main',
//       );
}
