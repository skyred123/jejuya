import 'package:jejuya/app/layers/data/sources/local/model/user/user.dart';
import 'package:jejuya/core/local_storage/local_storage.dart';

/// Shortcut for [LocalStorageKey].
typedef LSKey<T> = LocalStorageKey<T>;

/// Extension on [LocalStorageKey] that provides predefined keys.
extension LSKeyPredefinedExt<T> on LocalStorageKey<T> {
  // -- General data --

  /// Common data
  static const localStorageVersion = LSKey<int>('local_storage_version');

  // -- Settings data --

  /// Language settings
  static const language = LSKey<String>(
    'current_language',
    box: StorageBox.setting,
  );

  /// Theme settings
  static const theme = LSKey<String>(
    'current_theme',
    box: StorageBox.setting,
  );

  /// Current user local
  static const user = LSKey<User>('current_user');
}
