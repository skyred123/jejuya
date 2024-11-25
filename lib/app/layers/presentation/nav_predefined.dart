import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
// import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/create_schedule_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/create_schedule_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/destination_detail/destination_detail_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/destination_detail/destination_detail_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/error/error.dart';
import 'package:jejuya/app/layers/presentation/components/pages/error/error_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/favorite/favorite_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/favorite/favorite_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/home/home_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/map/map_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/map/map_page.dart';
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
import 'package:jejuya/app/layers/presentation/components/pages/profile_setting/profile_setting_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/profile_setting/profile_setting_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule/schedule_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule/schedule_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/schedule_detail_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/schedule_detail_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/search/search_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_in/sign_in_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_in/sign_in_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_up/sign_up_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/sign_up/sign_up_page.dart';
import 'package:jejuya/app/layers/presentation/components/pages/splash/splash_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/splash/splash_page.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/destination_info/destination_info_controller.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/destination_info/destination_info_sheet.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/filter/filter_controller.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/filter/filter_sheet.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/select_destination/select_destination_controller.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/select_destination/select_destination_sheet.dart';
import 'package:jejuya/core/arch/presentation/view/base_provider.dart';
import 'package:jejuya/core/navigation/navigator.dart' as navi;
import 'package:jejuya/app/layers/presentation/components/pages/search/search_controller.dart'
    as JejuyaSearch;

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

  /// Schedule page route.
  static const String map = '/map';

  /// Schedule page route.
  static const String schedule = '/schedule';

  /// Schedule detail page route.
  static const String scheduleDetail = '/schedule_detail?.*';

  /// Favorite page route.
  static const String favorite = '/favorite';

  /// Profile page route.
  static const String profile = '/profile';

  /// Notification page route.
  static const String notification = '/notification';

  /// Notification detail page route.
  static const String notificationDetail = '/notification_detail?.*';

  /// Desitnation detail page route.
  static const String destinationDetail = '/destination_detail?.*';

  /// Desitnation detail page route.
  static const String destinationInfo = '/destination_info';

  /// Filter sheet route.
  static const String filter = '/filter';

  /// Select destination sheet route.
  static const String selectDestination = '/select_destination';

  /// Create schedule page route.
  static const String createSchedule = '/create_schedule';

  /// Create profile setting page route.
  static const String profileSetting = '/profile_setting';

  /// Create error page route.
  static const String error = '/error';

  /// Create search page route.
  static const String search = '/search';
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
      name: PredefinedRoute.map,
      page: () => nav.map,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.schedule,
      page: () => nav.schedule,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.scheduleDetail,
      page: () {
        String? id =
            Uri.tryParse(Get.currentRoute)!.queryParameters['schedule_id']!;
        return nav.scheduleDetail(id);
      },
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.favorite,
      page: () => nav.favorite,
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
        return nav.notificationDetail(
          notificationId: id,
        );
      },
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.destinationDetail,
      // page: () => nav.destinationDetail,
      page: () {
        final id =
            Uri.tryParse(Get.currentRoute)!.queryParameters['destination_id']!;
        return nav.destinationDetail(destinationId: id);
      },
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.createSchedule,
      page: () => nav.createSchedule,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.profileSetting,
      page: () => nav.profileSetting,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.search,
      page: () => nav.search,
    ),
    GetPageEnsureAuth(
      name: PredefinedRoute.error,
      page: () => nav.error,
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

  /// Home page widget.
  Widget get map => BaseProvider(
        ctrl: MapController(),
        child: const MapPage(),
      );

  /// Home page widget.
  Widget get schedule => BaseProvider(
        ctrl: ScheduleController(),
        child: const SchedulePage(),
      );

  /// Home page widget.
  Widget scheduleDetail(String? scheduleId) => BaseProvider(
        ctrl: ScheduleDetailController(scheduleId: scheduleId),
        child: const ScheduleDetailPage(),
      );

  /// Home page widget.
  Widget get favorite => BaseProvider(
        ctrl: FavoriteController(),
        child: const FavoritePage(),
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

  /// Notification page widget.
  // Widget get destinationDetail => BaseProvider(
  //       ctrl: DestinationDetailController(),
  //       child: const DestinationDetailPage(),
  //     );
  Widget destinationDetail({
    required String? destinationId,
  }) =>
      BaseProvider(
        ctrl: DestinationDetailController(
          destinationId: destinationId,
        ),
        child: const DestinationDetailPage(),
      );

  /// Notification detail page widget.
  Widget notificationDetail({required num? notificationId}) => BaseProvider(
        ctrl: NotificationDetailController(notificationId: notificationId),
        child: NotificationDetailPage(),
      );

  /// Create schedule page widget.
  Widget get createSchedule => BaseProvider(
        ctrl: CreateScheduleController(),
        child: const CreateSchedulePage(),
      );

  Widget get profileSetting => BaseProvider(
        ctrl: ProfileSettingController(),
        child: ProfileSettingPage(),
      );

  Widget get error => BaseProvider(
        ctrl: ErrorController(),
        child: ErrorPage(),
      );

  /// Create search page widget.
  Widget get search => BaseProvider(
        ctrl: JejuyaSearch.SearchController(),
        child: const SearchPage(),
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

  /// Navigate to the map page.
  Future<T?>? toMap<T>() => toNamed(
        PredefinedRoute.map,
      );

  /// Navigate to the schedule page.
  Future<T?>? toSchedule<T>() => toNamed(
        PredefinedRoute.schedule,
      );

  /// Navigate to the schedule page.
  Future<T?>? toScheduleDetail<T>({required String? scheduleId}) => toNamed(
        PredefinedRoute.scheduleDetail
            .replaceAll('.*', 'schedule_id=$scheduleId'),
        arguments: scheduleId,
      );

  /// Navigate to the home page.
  Future<T?>? toFavorite<T>() => toNamed(
        PredefinedRoute.favorite,
      );

  /// Navigate to the home page.
  Future<T?>? toProfile<T>() => toNamed(
        PredefinedRoute.profile,
      );

  /// Navigate to the home page.
  Future<T?>? toDestinationDetail<T>({
    required String? destinationId,
  }) =>
      toNamed(
        PredefinedRoute.destinationDetail.replaceAll(
          '.*',
          'destination_id=$destinationId',
        ),
        arguments: {destinationId, destinationDetail},
      );

  Future<T?>? toNotificationDetail<T>({required num? notificationId}) =>
      toNamed(
        PredefinedRoute.notificationDetail
            .replaceAll('.*', 'notication_id=$notificationId'),
        arguments: notificationId,
      );

  /// Navigate to create schedule page.
  Future<T?>? toCreateSchedule<T>() => toNamed(
        PredefinedRoute.createSchedule,
      );

  Future<T?>? toProfileSetting<T>() => toNamed(
        PredefinedRoute.profileSetting,
      );

  Future<T?>? toError<T>() => toNamed(
        PredefinedRoute.error,
      );

  /// Navigate to search page.
  Future<T?>? toSearch<T>() => toNamed(
        PredefinedRoute.search,
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
  /// Show destination info sheet
  Future<T?>? showDetinationInfoSheet<T>({Destination? destination}) {
    return bottomSheet(
      BaseProvider(
        ctrl: DestinationInfoController(destination: destination),
        child: const DestinationInfoSheet(),
      ),
      routeName: PredefinedRoute.destinationInfo,
      isDismissible: true,
      enableDrag: false,
      isShowIndicator: true,
      backgroundColor: const Color(0xFF747480).withValues(alpha: 0.24),
      isDynamicSheet: true,
    );
  }

  /// Show filter sheet
  Future<T?>? showFilterSheet<T>() {
    return sideSheet(
      BaseProvider(
        ctrl: FilterController(),
        child: const FilterSheet(),
      ),
      routeName: PredefinedRoute.filter,
      isDismissible: true,
      enableDrag: false,
      initialChildSize: 0.6,
      isShowIndicator: false,
      backgroundColor: const Color(0xFF747480).withValues(alpha: 0.24),
      isDynamicSheet: true,
    );
  }

  /// Show select destination sheet
  Future<T?>? showSelectDestinationSheet<T>() {
    return bottomSheet(
      BaseProvider(
        ctrl: SelectDestinationController(),
        child: const SelectDestinationSheet(),
      ),
      routeName: PredefinedRoute.destinationInfo,
      isDismissible: true,
      enableDrag: false,
      isShowIndicator: true,
      backgroundColor: const Color(0xFF747480).withValues(alpha: 0.24),
      isDynamicSheet: true,
    );
  }
}
