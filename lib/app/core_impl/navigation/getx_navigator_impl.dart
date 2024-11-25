import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/exception/api_error.dart';
import 'package:jejuya/app/core_impl/exception/common_error.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/bottom_sheet/bottom_sheet_wrapper.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/app/app_controller.dart';
import 'package:jejuya/core/exception/base_error.dart';
import 'package:jejuya/core/navigation/navigator.dart' as nav;

/// Implementation of the [nav.Navigator] interface using the GetX package.
class GetxNavigator with GlobalControllerProvider implements nav.Navigator {
  /// Lock for showing snackbar
  final snackBarLock = Lock();

  @override
  Future<void> back<T>({
    T? result,
    bool closeOverlays = false,
    String? until,
  }) async {
    if (until != null) {
      return Get.until(
        (route) => route.settings.name == until,
      );
    }
    if (Get.previousRoute.isEmpty) {
      return toNamed(globalController<AppController>().initialRoute);
    }
    return Get.customBack(result: result, closeOverlays: closeOverlays);
  }

  @override
  Future<T?>? to<T>(
    Widget page, {
    required String routeName,
    nav.PushType pushType = nav.PushType.normal,
    Transition transition = Transition.fade,
  }) async {
    _unfocus();
    return switch (pushType) {
      nav.PushType.normal => Get.to<T?>(
          () => page,
          transition: transition,
          routeName: routeName,
        ),
      nav.PushType.replace => Get.off<T?>(
          () => page,
          transition: transition,
          routeName: routeName,
        ),
      nav.PushType.replaceAll => Get.offAll<T?>(
          () => page,
          transition: transition,
          routeName: routeName,
        )
    }
        ?.whenComplete(_refocus);
  }

  @override
  Future<T?>? toNamed<T>(
    String named, {
    dynamic arguments,
  }) async {
    _unfocus();
    return Get.toNamed<T?>(
      named,
      arguments: arguments,
    )?.whenComplete(_refocus);
  }

  @override
  Future<T?> bottomSheet<T>(
    Widget bottomsheet, {
    bool isShowIndicator = true,
    bool persistent = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool isDynamicSheet = false,
    bool enableKeyboardSafeArea = false,
    Color? barrierColor = Colors.black54,
    Color? backgroundColor,
    double initialChildSize = 0.5,
    bool shouldCloseWhenDraggedFromTop = true,
    List<double>? snapSizes = const [0.5, 0.8],
    String? routeName,
    EdgeInsets? padding,
    bool showFadeOnBottom = false,
  }) async {
    final context = Get.overlayContext;
    final globalRouteName = Get.routing.route?.settings.name;
    if (context == null) throw CommonError.missingContext;
    if (globalRouteName == routeName) return null;

    final wrappedDragableSheet = BottomSheetBuilderExt.build(
      initialChildSize: initialChildSize,
      snapSizes: snapSizes,
      shouldCloseWhenDraggedFromTop: shouldCloseWhenDraggedFromTop,
      child: bottomsheet,
      backgroundColor: backgroundColor ?? context.color.containerBackground,
      isShowIndicator: isShowIndicator,
      isDynamicSheet: isDynamicSheet,
      draggableSheetWithoutScrollWrapper: isScrollControlled,
      padding: padding,
    );

    _unfocus();
    return showModalBottomSheet<T?>(
      context: context,
      barrierColor: barrierColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: true,
      isDismissible: isDismissible,
      routeSettings: RouteSettings(name: routeName),
      enableDrag: enableDrag,
      builder: (BuildContext context) {
        if (enableKeyboardSafeArea) {
          final bottomInset = MediaQuery.of(context).viewInsets.bottom;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Transform.translate(
              offset: Offset(0, bottomInset > 0 ? -bottomInset : 0),
            ).transform,
            child: wrappedDragableSheet,
          );
        } else {
          return wrappedDragableSheet;
        }
      },
    ).whenComplete(_refocus);
  }

  @override
  Future<SnackbarController> showSnackBar({
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    Widget? mainButton,
    dynamic error,
  }) async =>
      snackBarLock.synchronized(() async {
        await Get.closeCurrentSnackbar();

        // Only this block can run (once) until done
        final parsedMessage = switch (error) {
          null => message != null ? tr(message) : null,
          _ => () {
              if (error is String) return tr(error);
              if (error is DioException) return tr(error.toApiError().message);
              return tr(
                error is BaseError
                    ? error.message
                    : CommonError.unknown.message,
              );
            }(),
        };
        final context = Get.context;
        if (context == null || !context.mounted) {
          throw CommonError.missingContext;
        }

        final controller = Get.showSnackbar(
          GetSnackBar(
            margin: EdgeInsets.all(16.rMin),
            padding: EdgeInsets.all(16.rMin),
            borderRadius: 16.rMin,
            animationDuration: const Duration(milliseconds: 500),
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            title: title,
            message: parsedMessage,
            titleText: titleText,
            messageText: messageText,
            backgroundColor: context.color.primaryColor.withValues(alpha: 0.7),
            barBlur: 10,
            icon: icon,
            onTap: (_) {
              Get.closeCurrentSnackbar();
            },
            mainButton: mainButton ??
                Icon(
                  CupertinoIcons.xmark_circle_fill,
                  size: 16.spMin,
                  color: Colors.white,
                ).marginOnly(right: 16.wMin),
          ),
        );
        return controller;
      });

  @override
  Future<T?> dialog<T>(
    Widget dialog, {
    bool isDismissible = true,
    Color? barrierColor,
    String? routeName,
  }) async {
    _unfocus();
    return Get.customDialog<T?>(
      dialog,
      barrierDismissible: isDismissible,
      barrierColor: barrierColor,
      transitionCurve: Curves.easeOut,
      transitionDuration: const Duration(milliseconds: 300),
      useSafeArea: false,
      routeSettings: RouteSettings(name: routeName),
    ).whenComplete(_refocus);
  }

  /// Cache current focus state, unfocus, and refocus later.
  FocusScopeNode? _cachedFocus;

  void _unfocus() {
    final context = Get.context;
    if (context == null) return;

    /// Unfocus & cache the current focus state to refocus later
    final currentFocusNode = FocusScope.of(context);
    if (currentFocusNode.hasFocus) {
      _cachedFocus = currentFocusNode;
      _cachedFocus?.unfocus();
    } else {
      _cachedFocus = null;
    }
  }

  void _refocus() {
    final context = Get.context;
    if (context == null) return;

    /// Refocus the cached focus state
    _cachedFocus?.requestFocus();
    _cachedFocus = null;
  }

  @override
  Future<T?> sideSheet<T>(
    Widget sideSheet, {
    bool isShowIndicator = true,
    bool persistent = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool isDynamicSheet = false,
    Color? barrierColor = Colors.black54,
    Color? backgroundColor,
    double initialChildSize = 0.5,
    bool shouldCloseWhenDraggedFromTop = true,
    List<double>? snapSizes = const [0.5, 0.8],
    String? routeName,
    EdgeInsets? padding,
    bool enableKeyboardSafeArea = false,
  }) async {
    final context = Get.overlayContext;
    final globalRouteName = Get.routing.route?.settings.name;
    if (context == null) throw CommonError.missingContext;
    if (globalRouteName == routeName) return null;

    _unfocus();
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * initialChildSize,
            color: backgroundColor ?? context.color.containerBackground,
            child: Column(
              children: [
                if (isShowIndicator)
                  Container(
                    margin: EdgeInsets.all(8.rMin),
                    width: 40.wMin,
                    height: 4.hMin,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2.rMin),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: sideSheet,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        );
      },
    ).whenComplete(_refocus);
  }
}

/// Extension method on `GetInterface` to show a custom dialog.
extension CustomDialogExt on GetInterface {
  /// Shows a custom dialog.
  Future<T?> customDialog<T>(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    final context = Get.context;
    if (context == null) throw CommonError.missingContext;
    final theme = Theme.of(context);
    return Get.generalDialog<T>(
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        final pageChild = widget;
        Widget dialog = Builder(
          builder: (context) {
            return Theme(data: theme, child: pageChild);
          },
        );
        if (useSafeArea) {
          dialog = SafeArea(child: dialog);
        }
        return dialog;
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black54,
      transitionDuration:
          transitionDuration ?? Get.defaultDialogTransitionDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: transitionCurve ?? Get.defaultDialogTransitionCurve,
          ),
          child: child,
        );
      },
      navigatorKey: navigatorKey,
      routeSettings:
          routeSettings ?? RouteSettings(arguments: arguments, name: name),
    );
  }
}

extension on GetInterface {
  /// Overriding the default back behavior without hiding the snackbar
  void customBack<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    if (closeOverlays && isOverlaysOpen) {
      navigator?.popUntil((route) {
        return !isDialogOpen! && !isBottomSheetOpen!;
      });
    }
    if (canPop) {
      if (global(id).currentState?.canPop() ?? false) {
        global(id).currentState?.pop<T>(result);
      }
    } else {
      global(id).currentState?.pop<T>(result);
    }
  }
}
