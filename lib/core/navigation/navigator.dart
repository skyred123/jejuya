import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

/// Enum representing different types of push operations in navigation.
enum PushType {
  /// Normal push operation.
  normal,

  /// Replace the current route with a new route.
  replace,

  /// Replace all existing routes with a new route.
  replaceAll,
}

/// Interface for navigating between screens.
abstract interface class Navigator {
  /// Navigates to a new screen.
  ///
  /// [page] - The widget representing the new screen.
  /// [routeName] - The name of the route.
  /// [pushType] - The type of navigation push.
  /// [transition] - The transition animation type.
  Future<T?>? to<T>(
    Widget page, {
    required String routeName,
    PushType pushType = PushType.normal,
    Transition transition = Transition.fade,
  });

  /// Navigates to a named route.
  ///
  /// [named] - The name of the route.
  /// [arguments] - The arguments to pass to the route.
  Future<T?>? toNamed<T>(
    String named, {
    dynamic arguments,
  });

  /// Goes back to the previous screen.
  ///
  /// [result] - The result to return to the previous screen.
  /// [closeOverlays] - Whether to close all overlays.
  Future<void> back<T>({
    T? result,
    bool closeOverlays = false,
    String? until,
  });

  /// Shows a bottom sheet.
  ///
  /// [bottomsheet] - The widget representing the bottom sheet.
  /// [isShowIndicator] - Whether to show the indicator.
  /// [persistent] - Whether the bottom sheet is persistent.
  /// [isDismissible] - Whether the bottom sheet is dismissible.
  /// [enableDrag] - Whether dragging is enabled.
  /// [isScrollControlled] - Whether scrolling is controlled.
  /// [isDynamicSheet] - Whether the sheet is dynamic height.
  /// [barrierColor] - The color of the barrier.
  /// [backgroundColor] - The background color of the bottom sheet.
  /// [initialChildSize] - The initial size of the child.
  /// [shouldCloseWhenDraggedFromTop] - Whether to close when dragged from top.
  /// [snapSizes] - The sizes to snap to during dragging.
  /// [routeName] - The name of the route.
  /// [padding] - The padding of the bottom sheet.
  /// [enableKeyboardSafeArea] - Whether to enable the keyboard safe area.
  Future<T?> bottomSheet<T>(
    Widget bottomsheet, {
    bool isShowIndicator = true,
    bool persistent = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool isDynamicSheet = false,
    Color? barrierColor,
    Color? backgroundColor,
    double initialChildSize = 0.5,
    bool shouldCloseWhenDraggedFromTop = true,
    List<double>? snapSizes = const [0.5, 0.8],
    String? routeName,
    EdgeInsets? padding,
    bool enableKeyboardSafeArea = false,
  });

  /// Shows a dialog.
  ///
  /// [dialog] - The widget representing the dialog.
  /// [isDismissible] - Whether the dialog is dismissible.
  /// [barrierColor] - The color of the barrier.
  /// [routeName] - The name of the route.
  Future<T?> dialog<T>(
    Widget dialog, {
    bool isDismissible = true,
    Color? barrierColor,
    String? routeName,
  });

  /// Shows a snackbar.
  ///
  /// [title] - The title of the snackbar.
  /// [message] - The message of the snackbar.
  /// [titleText] - The title widget of the snackbar.
  /// [messageText] - The message widget of the snackbar.
  /// [icon] - The icon widget of the snackbar.
  /// [mainButton] - The main button widget of the snackbar.
  /// [error] - The error object to display.
  void showSnackBar({
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    Widget? mainButton,
    dynamic error,
  });

  /// Shows a side sheet.
  ///
  /// [sideSheet] - The widget representing the side sheet.
  /// [isShowIndicator] - Whether to show the indicator.
  /// [persistent] - Whether the side sheet is persistent.
  /// [isDismissible] - Whether the side sheet is dismissible.
  /// [enableDrag] - Whether dragging is enabled.
  /// [isScrollControlled] - Whether scrolling is controlled.
  /// [isDynamicSheet] - Whether the side sheet is dynamic width.
  /// [barrierColor] - The color of the barrier.
  /// [backgroundColor] - The background color of the side sheet.
  /// [initialChildSize] - The initial size of the child.
  /// [shouldCloseWhenDraggedFromTop] - Whether to close when dragged from top.
  /// [snapSizes] - The sizes to snap to during dragging.
  /// [routeName] - The name of the route.
  /// [padding] - The padding of the side sheet.
  /// [enableKeyboardSafeArea] - Whether to enable the keyboard safe area.
  Future<T?> sideSheet<T>(
    Widget sideSheet, {
    bool isShowIndicator = true,
    bool persistent = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool isDynamicSheet = false,
    Color? barrierColor,
    Color? backgroundColor,
    double initialChildSize = 0.5,
    bool shouldCloseWhenDraggedFromTop = true,
    List<double>? snapSizes = const [0.5, 0.8],
    String? routeName,
    EdgeInsets? padding,
    bool enableKeyboardSafeArea = false,
  });
}
