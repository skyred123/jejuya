import 'dart:convert';

import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/core/local_storage/local_storage.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';
import 'package:jejuya/core/reactive/simple_obs_data.dart';
import 'package:mobx/mobx.dart';

final _converter = <String, SettingValueConverter<dynamic, dynamic>>{};

/// Registers a converter for a specific type.
void registerSettingConverter<D, S>(
  SettingValueConverter<D, S> converter,
) =>
    _converter[_convertKey<D>()] =
        converter as SettingValueConverter<dynamic, dynamic>;

String _convertKey<D>() => D.toString().replaceAll('?', '');
bool _hasConverter<D>() => _converter.containsKey(_convertKey<D>());

SettingValueConverter<dynamic, dynamic> _getConverter<D>() =>
    _converter[_convertKey<D>()]!;

/// A class that represents an observable setting with the ability to store
/// and retrieve data from local storage.
class ObsSetting<T> extends SimpleObsData<T> with LocalStorageProvider {
  /// Creates a new instance of [ObsSetting].
  ///
  /// The [key] parameter is required to specify the storage key.
  /// The [initValue] parameter is optional and sets the initial data value.
  ObsSetting({
    required this.key,
    required super.initValue,
    super.context,
    super.name,
  }) : _error = Observable(
          null,
          context: context,
          name: name != null ? '${name}_error' : null,
        ) {
    untracked(() {
      try {
        final initValue = this.initValue;
        if (<T>[] is List<SettingJsonValue?>) {
          /// Get the raw value from local storage,
          final rawValue = localStorage.get(key) as String?;
          super.value =
              rawValue != null ? jsonDecode(rawValue) as T : initValue;
        } else if (_hasConverter<T>()) {
          /// If the initial value is not a SettingRawValue,
          /// but a converter is registered for the type,
          /// use the converter to load the value.
          final converter =
              _getConverter<T>() as SettingValueConverter<T, dynamic>;
          final rawValue = localStorage.get(key);
          super.value = rawValue != null
              ? converter.fromStorableValue(rawValue) ?? initValue
              : initValue;
        } else {
          /// If the initial value is not a SettingRawValue,
          /// just get it from local storage.
          super.value =
              localStorage.get(key as LocalStorageKey<T>) ?? initValue;
        }
      } catch (err, stackTrace) {
        // Log any errors that occur while loading the data.
        log.error(
          '[ObsSetting] ${key.key} Initial error: $_error!',
          error: _error,
          stackTrace: stackTrace,
        );
        _error.value = err;
      }
    });
  }

  /// The key used to save and retrieve the data from local storage.
  final LocalStorageKey<dynamic> key;

  /// The error that occurred while loading the data.
  final Observable<dynamic> _error;

  // Sets the data value and handles any errors.
  @override
  set value(T value) => transaction(() {
        if (value == this.value) return;
        // Cache the previous data value.
        final previousValue = this.value;

        try {
          // Set the new data value.
          super.value = value;

          // Clear any errors.
          _error.value = null;

          /// If the value is a SettingRawValue,
          /// store the raw value in local storage.
          if (value is SettingJsonValue) {
            localStorage.put(key, jsonEncode(value));
          } else if (_hasConverter<T>()) {
            /// If the value is not a SettingRawValue,
            /// but a converter is registered for the type,
            /// use the converter to store the value.
            final converter =
                _getConverter<T>() as SettingValueConverter<T, dynamic>;
            localStorage.put(key, converter.toStorableValue(value));
          } else {
            // Otherwise, store the value directly.
            localStorage.put(key, value);
          }

          log.debug('[ObsSetting] ${key.key} Save done with value: $value!');
        } catch (err, stackTrace) {
          /// If an error occurs,
          /// restore the previous data value and set the error.
          super.value = previousValue;
          _error.value = err;

          log.error(
            '[ObsSetting] ${key.key} Svae error: $err, value: $value!',
            error: err,
            stackTrace: stackTrace,
          );
          rethrow;
        }
      });

  /// The error that occurred while loading the data.
  dynamic get error => _error.value;
}

/// A class that represents a json value that can be stored in local storage.
abstract class SettingJsonValue {}

/// Adapter for parsing a dynamic object
abstract class SettingValueConverter<D, S> {
  /// Empty constant constructor so that subclasses can have a constant
  /// constructor.
  const SettingValueConverter();

  /// Map a value from an object in Dart into something that will be understood
  /// by the database.
  S? toStorableValue(D? dynamicValue);

  /// Maps a column from the database back to Dart.
  D? fromStorableValue(S? storableValue);
}
