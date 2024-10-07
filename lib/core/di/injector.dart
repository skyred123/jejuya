import 'dart:async';

import 'package:jejuya/core/analytic/analytic_service.dart';
import 'package:jejuya/core/logger/app_logger.dart';
import 'package:jejuya/core/navigation/navigator.dart';
import 'package:get_it/get_it.dart';

/// A dependency injection manager.
abstract class Injector {
  /// Singleton constructor
  const Injector();

  /// Dependency injection manager
  static final _getIt = GetIt.I;

  /// Navigation manager
  Navigator get navigator => get();

  /// Logger manager
  AppLogger get logger => get();

  /// Analytics manager
  AnalyticService get analytics => get();

  /// Setup all of the dependencies
  Future<void> initialize();

  /// Resets the injector by re-injecting the global state, ...
  /// Useful for reset the cache data/state when logout
  Future<void> reset();

  /// Returns an instance of [T] obtained through the [GetIt.get] method.
  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
    Type? type,
  }) {
    return _getIt.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
      type: type,
    );
  }

  /// Registers a lazy singleton by calling the provided factory function
  /// to create an instance when first needed.
  ///
  /// If an instance with the same name already exists,
  /// it will be disposed and recreated when first accessed.
  /// `resetable` controls whether an existing instance can be reset.
  ///
  /// The registered instance will be disposed when it is no longer needed.
  Future<void> registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
    bool resetable = true,
  }) async {
    if (resetable && _getIt.isRegistered<T>()) {
      await unregister<T>(instanceName: instanceName);
    }
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerLazySingleton<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );
    }
  }

  /// Registers a singleton instance of [T] in the injector.
  ///
  /// If an instance with the same [instanceName] already exists, it will be
  /// disposed and re-registered when accessed again. [resetable] controls
  /// whether an existing instance can be reset.
  ///
  /// The registered instance will be disposed when it is no longer needed.
  Future<T> registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
    bool resetable = true,
  }) async {
    if (resetable && _getIt.isRegistered<T>(instanceName: instanceName)) {
      await unregister<T>(instanceName: instanceName);
    }
    if (!_getIt.isRegistered<T>(instanceName: instanceName)) {
      return _getIt.registerSingleton<T>(
        instance,
        instanceName: instanceName,
        signalsReady: signalsReady,
        dispose: dispose,
      );
    }
    return _getIt.get<T>();
  }

  /// Registers a factory for creating instances of [T] in the injector.
  ///
  /// This allows creating new instances of [T] each time it is requested.
  /// [factoryFunc] will be invoked to create new instances.
  ///
  /// [instanceName] can be used to identify the registered factory.
  ///
  /// If [resetable] is true and a factory with the same [instanceName]
  /// already exists, it will be unregistered before registering the new one.
  Future<void> registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    bool resetable = true,
  }) async {
    if (resetable && _getIt.isRegistered<T>(instanceName: instanceName)) {
      await unregister<T>(instanceName: instanceName);
    }
    return _getIt.registerFactory<T>(factoryFunc, instanceName: instanceName);
  }

  /// Registers a factory function that accepts two parameters for creating
  /// instances of [T] in the injector.
  ///
  /// This allows creating new instances of [T] each time it is requested by
  /// calling the [factoryFunc] with the given parameters [P1] and [P2].
  ///
  /// [instanceName] can be used to identify the registered factory.
  ///
  /// If [resetable] is true and a factory with the same [instanceName] already
  /// exists, it will be unregistered before registering the new one.
  Future<void> registerFactoryParam<T extends Object, P1, P2>(
    FactoryFuncParam<T, P1, P2> factoryFunc, {
    String? instanceName,
    bool resetable = true,
  }) async {
    if (resetable && _getIt.isRegistered<T>(instanceName: instanceName)) {
      await unregister<T>(instanceName: instanceName);
    }
    return _getIt.registerFactoryParam<T, P1, P2>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  /// Unregisters an instance or factory from the injector.
  ///
  /// Use [instance] or [instanceName] to identify the registered instance.
  /// [disposingFunction] will be invoked when disposing the instance.
  ///
  /// Returns the removed instance if it was cached.
  FutureOr<dynamic> unregister<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr<dynamic> Function(T)? disposingFunction,
  }) {
    return _getIt.unregister<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }
}
