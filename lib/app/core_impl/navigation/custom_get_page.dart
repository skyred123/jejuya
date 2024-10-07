import 'package:jejuya/app/core_impl/navigation/middleware.dart';
import 'package:get/get.dart';

/// Class extends the GetPage to ensure that the user is authenticated.
class GetPageEnsureAuth<T> extends GetPage<T> {
  /// Constructor for the GetPageEnsureAuth class.
  GetPageEnsureAuth({
    required super.name,
    required super.page,
    super.popGesture = true,
    List<GetMiddleware>? middlewares,
  }) : super(
          middlewares: [EnsureAuthMiddleware(), ...?middlewares],
          transition: Transition.fadeIn,
        );
}

/// Class extends the GetPage to ensure that the user is not authenticated.
class GetPageEnsureNotAuth<T> extends GetPage<T> {
  /// Constructor for the GetPageEnsureNotAuth class.
  GetPageEnsureNotAuth({
    required super.name,
    required super.page,
    List<GetMiddleware>? middlewares,
  }) : super(
          middlewares: [EnsureNotAuthedMiddleware(), ...?middlewares],
          transition: Transition.fadeIn,
        );
}
