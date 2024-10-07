import 'package:jejuya/app/layers/presentation/global_controllers/loading_overlay/loading_overlay_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';

/// This file contains mixins that provide access to various controllers
/// that are used to manage the state of the application. These controllers
/// are implemented using the MobX library and are injected using the
/// [InjectorImpl._injectGlobalStates] method from the [Injector] class
/// for the global state & via the [Provider] widget
/// under the [NavPredefined] for the local state.
///
/// There are mixins for both local and global state. Local state mixins
/// are used to provide access to controllers that are specific to a
/// particular page, while global state mixins are used to provide
/// access to controllers that manage the state of the entire application.
///
/// To use these mixins, simply include them in your widget or state class
/// using the `with` keyword. For example:
///
/// ```dart
/// class MyWidget extends StatelessWidget
///   with ControllerProvider<YourController>, AppControllerProvider {
///   @override
///   Widget build(BuildContext context) {
///     // Use yourController to manage the state of this widget
///     final ctrl = controller(context);
///     // Use appController to access the global state of the application
///     final appCtrl = appController;
///     return Container();
///   }
/// }
/// ```
///
/// Note that you must also import the necessary controller classes in
/// order to use these mixins.
mixin ControllerProvider<T extends BaseController> {
  /// Returns the instance of the controller of type `T` that is associated
  /// with the given `BuildContext`. If `listen` is true, the widget will
  /// rebuild when the controller's state changes.
  T controller(BuildContext context, {bool listen = false}) =>
      Provider.of<T>(context, listen: listen);
}

/// A mixin that provides access to the global controller instance.
mixin GlobalControllerProvider {
  /// Returns the global controller instance of type `T`.
  T globalController<T extends BaseController>() => inj.get<BaseController>(
        instanceName: T.toString(),
      ) as T;

  /// Run with loading overlay
  Future<T> runWithLoadingOverlay<T>(
    Future<T> Function() func, {
    Duration? timeout = const Duration(seconds: 30),
    Duration? minimumLoadingTime = const Duration(milliseconds: 1500),
  }) =>
      globalController<LoadingOverlayController>().run(
        func,
        timeout: timeout,
        minimumLoadingTime: minimumLoadingTime,
      );
}
