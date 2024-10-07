import 'package:jejuya/core/local_storage/local_storage.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';

/// A mixin that provides access to a [LocalStorage] instance.
///
/// This mixin provides a getter method `localStorage`
/// that returns an instance of [LocalStorage].
/// The [LocalStorage] instance is obtained through the
/// [InjectorImpl._injectLocalStorage] method, which is responsible for
/// managing dependencies in the application.
mixin LocalStorageProvider {
  /// Returns an instance of [LocalStorage] obtained through the
  /// [InjectorImpl._injectLocalStorage] method.
  LocalStorage get localStorage => inj.get();
}
