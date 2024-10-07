import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/ls_key_predefined.dart';

/// An enum representing different storage boxes for local storage.
enum StorageBox {
  /// The default storage box.
  defaultX,

  /// The storage box for settings.
  setting,
  ;

  /// Returns the name of the storage box.
  String get name {
    var prefix = LSKeyPredefinedExt.user.key;
    switch (this) {
      case StorageBox.defaultX:
        return '${prefix}_defaultDk';
      case StorageBox.setting:
        return '${prefix}settingDk';
    }
  }
}

/// A key-value pair for storing and retrieving data from local storage.
class LocalStorageKey<T> {
  /// Creates a new [LocalStorageKey] with the given [key] and [box].
  const LocalStorageKey(this.key, {this.box = StorageBox.defaultX});

  /// The key for the local storage.
  final String key;

  /// The storage box for the local storage.
  final StorageBox box;
}

/// An interface for local storage.
abstract class LocalStorage {
  /// The current version of the local storage.
  static int currentVerion =
      inj.get<LocalStorage>().get(LSKeyPredefinedExt.localStorageVersion) ?? 0;

  /// The version of the local storage.
  int get version;

  /// Migrates the local storage to a new version.
  Future<void> migrate();

  /// Retrieves the value associated with the given [key].
  ///
  /// Returns `null` if the key is not found.
  T? get<T>(LocalStorageKey<T> key);

  /// Retrieves the list associated with the given [key].
  ///
  /// Returns `null` if the key is not found.
  List<T>? getList<T>(LocalStorageKey<List<T>> key);

  /// Stores the given [value] with the given [key].
  Future<void> put<T>(LocalStorageKey<T> key, T value);

  /// Deletes the value associated with the given [key].
  Future<void> delete<T>(LocalStorageKey<T> key);
}
