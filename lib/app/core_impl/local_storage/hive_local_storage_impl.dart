import 'package:hive_flutter/hive_flutter.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/ls_key_predefined.dart';
import 'package:jejuya/core/local_storage/local_storage.dart';

/// A [LocalStorage] implementation using Hive as the underlying storage.
class HiveLocalStorage extends LocalStorage {
  /// Returns the box name for the given [key].
  String getBoxName<T>(LocalStorageKey<T> key) => key.box.name;

  @override
  int get version => 0;

  /// Migrates data to the new version.
  @override
  Future<void> migrate() async {
    const localStorageVersionKey = LSKeyPredefinedExt.localStorageVersion;
    var currentVersion = get(localStorageVersionKey) ?? 0;
    while (currentVersion < version) {
      // Migrate data to the new version
      switch (currentVersion) {
        case 0:
          break;
      }
      currentVersion += 1;
      await put(localStorageVersionKey, currentVersion);
    }
    log.info('[HiveLocalStorage] Initialized successfully');
  }

  /// Returns the value for the given [key].
  @override
  T? get<T>(LocalStorageKey<T> key) {
    return Hive.box<dynamic>(getBoxName(key)).get(key.key) as T?;
  }

  /// Returns the list value for the given [key].
  @override
  List<T>? getList<T>(LocalStorageKey<List<T>> key) {
    return get<List<dynamic>>(LocalStorageKey(key.key, box: key.box))
        ?.cast<T>();
  }

  /// Puts the given [value] for the given [key].
  @override
  Future<void> put<T>(LocalStorageKey<T> key, T value) {
    return Hive.box<dynamic>(getBoxName(key)).put(key.key, value);
  }

  /// Deletes the value for the given [key].
  @override
  Future<void> delete<T>(LocalStorageKey<T> key) {
    return Hive.box<dynamic>(getBoxName(key)).delete(key.key);
  }
}
