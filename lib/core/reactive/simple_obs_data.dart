import 'package:mobx/mobx.dart';

/// A class that holds data and its status for use in reactive programming.
class SimpleObsData<T> {
  /// Creates a new instance of [SimpleObsData].
  ///
  /// The [initValue] parameter is optional and defaults to `null`.
  /// The [context] parameter is optional and is used to specify the
  /// [ReactiveContext] in which the data will be observed.
  /// The [name] parameter is optional and is used to specify the name of the
  /// data for debugging purposes.
  SimpleObsData({
    required T initValue,
    ReactiveContext? context,
    String? name,
  })  : _initValue = initValue,
        _data = Observable(initValue, context: context, name: name);

  final T _initValue;

  /// The data held by this instance.
  final Observable<T> _data;

  /// Sets the data value.
  ///
  /// This method runs the update in an action to ensure that it is executed
  /// atomically and that any reactions that depend on this data are notified.
  set value(T value) => runInAction(() => _data.value = value);

  /// Gets the data value.
  T get value => _data.value;

  /// Gets the initial value of the data.
  T get initValue => _initValue;

  /// Resets the data to the initial value.
  void reset() => value = initValue;

  /// Notifies any observers that the data has changed.
  void reportChanged() => _data.reportChanged();
}
