import 'package:jejuya/app/core_impl/exception/common_error.dart';
import 'package:jejuya/core/local_storage/local_storage.dart';
import 'package:jejuya/core/reactive/obs_data.dart';
import 'package:jejuya/core/reactive/obs_setting.dart';
import 'package:jejuya/core/reactive/simple_obs_data.dart';
import 'package:mobx/mobx.dart';

/// Returns a [SimpleObsData] object that represents a simple observable data.
///
/// The [initValue] parameter is the initial value of the observable data.
/// The [context] parameter is the reactive context associated with the data.
/// The [name] parameter is an optional name for the data.
SimpleObsData<T> listenable<T>(
  T initValue, {
  ReactiveContext? context,
  String? name,
}) =>
    SimpleObsData(initValue: initValue, context: context, name: name);

/// Creates a [Computed] object that listens to changes in the dependencies and
/// recomputes its value when any of the dependencies change.
///
/// The [compute] func is called to calculate the value of the [Computed] obj.
/// The [context] parameter is the reactive context associated with the data.
/// The [name] parameter is an optional name for the data.
Computed<T> listenableComputed<T>(
  T Function() compute, {
  ReactiveContext? context,
  String? name,
}) =>
    Computed(compute, context: context, name: name);

/// Returns an [ObsData] object that represents observable data
/// with status and error handling.
///
/// The [initValue] parameter is the initial value of the observable data.
/// The [error] parameter is an optional error associated with the data.
/// The [status] parameter is the status of the data
/// (default is [ObsDataStatus.initial]).
/// The [context] parameter is the reactive context associated with the data.
/// The [name] parameter is an optional name for the data.
ObsData<T> listenableStatus<T>(
  T initValue, {
  dynamic error,
  ObsDataStatus status = ObsDataStatus.initial,
  ReactiveContext? context,
  String? name,
}) =>
    ObsData(
      initValue: initValue,
      error: error,
      status: status,
      context: context,
      name: name,
    );

/// Returns an [ObsSetting] object that represents an observable setting.
///
/// The [initValue] parameter is the initial value of the setting.
/// The [key] parameter is the storage key for the setting.
/// The [context] parameter is the reactive context associated with the setting.
/// The [name] parameter is an optional name for the setting.
ObsSetting<T> listenableSetting<T>(
  T initValue, {
  required LocalStorageKey<T> key,
  ReactiveContext? context,
  String? name,
}) =>
    ObsSetting(
      initValue: initValue,
      key: key,
      name: name,
    );

/// Returns an [ObservableFuture] object that represents an observable future.
///
/// The [future] parameter is the future to observe.
/// The [context] parameter is the reactive context associated.
/// The [name] parameter is an optional name for the future.
ObservableFuture<T> listenableFuture<T>(
  Future<T> future, {
  ReactiveContext? context,
  String? name,
}) =>
    ObservableFuture(future, context: context, name: name);

/// Returns an [ObservableList] object that represents an observable list.
///
/// The [initValue] parameter is the initial value of the list.
/// The [context] parameter is the reactive context associated with the list.
/// The [name] parameter is an optional name for the list.
ObservableList<T> listenableList<T>(
  List<T> initValue, {
  ReactiveContext? context,
  String? name,
}) =>
    ObservableList.of(initValue, context: context, name: name);

/// Returns an [ObservableMap] object that represents an observable map.
///
/// The [initValue] parameter is the initial value of the map.
/// The [context] parameter is the reactive context associated with the map.
/// The [name] parameter is an optional name for the map.
ObservableMap<K, V> listenableMap<K, V>(
  Map<K, V> initValue, {
  ReactiveContext? context,
  String? name,
}) =>
    ObservableMap.of(initValue, context: context, name: name);

/// Returns an [ObservableSet] object that represents an observable set.
///
/// The [initValue] parameter is the initial value of the set.
/// The [context] parameter is the reactive context associated with the set.
/// The [name] parameter is an optional name for the set.
ObservableSet<T> listenableSet<T>(
  Set<T> initValue, {
  ReactiveContext? context,
  String? name,
}) =>
    ObservableSet.of(initValue, context: context, name: name);

/// Returns an [ObservableStream] object that represents an observable stream.
///
/// The [stream] parameter is the stream to observe.
/// The [context] parameter is the reactive context associated.
/// The [name] parameter is an optional name for the stream.
ObservableStream<T> listenableStream<T>(
  Stream<T> stream, {
  ReactiveContext? context,
  String? name,
}) =>
    ObservableStream(stream, context: context, name: name);

/// Extension method to assign a dynamic value to a [SimpleObsData] object.
extension DynamicToSimpleObsDataExtension<T> on T {
  /// Assign a value to a [SimpleObsData] object.
  void assignTo(SimpleObsData<T?> obsData) => obsData.value = this;

  /// Assign a value to a [ObsData] object with status [ObsDataStatus.success].
  void assignToStatus(ObsData<T?> obsData) => transaction(
        () => obsData
          ..value = this
          ..error = null
          ..status = ObsDataStatus.success,
      );
}

/// Extension method to assign a dynamic value to a [SimpleObsData] object.
extension DynamicFutureToSimpleObsDataExtension<T> on Future<T> {
  /// Assigns the result of [Future] to the given [SimpleObsData] instance.
  Future<void> assignValueTo(SimpleObsData<T?> obsData) async =>
      obsData.value = await this;
}

/// Extension method to assign a dynamic value to an [ObservableSet] object.
extension DynamicFutureToObsExtension<T> on Future<T> {
  /// Creates a new [ObservableList] obj with the current as the initial value.
  ObservableFuture<T> get sof => ObservableFuture(this);

  /// Assigns the result of [Future] to the given [ObsData] instance.
  ///
  /// If [loadingStatus] is not provided, the status of the [ObsData]
  /// instance will be set to [ObsDataStatus.loading] or
  /// [ObsDataStatus.refreshing] based on its current status.
  ///
  /// If [loadingStatus] is provided, the status of the [ObsData]
  /// instance will be set to the provided status.
  ///
  /// If the current value of the [ObsData] instance is
  /// [ObsDataStatus.loadingMore], the result of this [Future] will be
  /// assigned to the [ObsData] instance without changing its status.
  ///
  /// If an error occurs while executing this [Future], the [ObsData]
  /// instance will have its [ObsData.error] and [ObsData.status]
  /// properties updated accordingly.
  /// If [shouldRethrow] is `true`, the error will be rethrown.
  Future<void> assignTo(
    ObsData<T?> observableData, {
    bool shouldRethrow = true,
    ObsDataStatus? loadingStatus,
    bool shouldSkipDuplicate = true,
    bool skipNullOrError = false,
    Future<void> Function()? prepareForUpdate,
  }) async {
    try {
      // Determine new status based on current status and loadingStatus.
      ObsDataStatus newStatus;
      if (loadingStatus == null) {
        // Set new status based on current status.
        newStatus = observableData.status == ObsDataStatus.initial
            ? ObsDataStatus.loading
            : ObsDataStatus.refreshing;
      } else {
        // Set new status to provided value.
        newStatus = loadingStatus;
      }

      /// Skip assignment if new status is same as current status
      /// and shouldSkipDuplicate is true.
      if (shouldSkipDuplicate && newStatus == observableData.status) {
        return;
      }

      // Set new status for observableData.
      observableData.status = newStatus;

      // Append new data if current status is loadingMore.
      final T? value;
      if (observableData.status == ObsDataStatus.loadingMore) {
        // Throw error if data is not Pagination object.
        if (observableData.value is! Pagination) {
          throw CommonError.invalidType;
        }

        // Get new page of data.
        final newPage = await this;

        // Insert new items into existing data.
        (newPage as Pagination)
            .items
            .insertAll(0, (observableData.value as Pagination?)?.items ?? []);

        // Set new data for observableData.
        value = newPage;
      } else {
        // Get new data.
        final newValue = await this;
        await prepareForUpdate?.call();

        /// Set new data for observableData,
        /// skipping null or error values if skipNullOrError is true.
        value =
            (skipNullOrError ? (newValue ?? observableData.value) : newValue);
      }

      /// Execute transaction to update data and status.
      /// Using nested action to avoid unnecessary rebuilds.
      runInAction(() {
        // Set error and status to null and success, respectively.
        observableData
          ..value = value
          ..error = null
          ..status = ObsDataStatus.success;
      });
    } catch (error) {
      /// Handle skipNullOrError case.
      /// Using nested action to avoid unnecessary rebuilds.
      runInAction(() {
        if (skipNullOrError) {
          observableData
            ..error = null
            ..status = ObsDataStatus.success;
          return;
        }

        // Set error and status for non-skipNullOrError case.
        observableData
          ..error = error
          ..status = ObsDataStatus.error;
      });

      // Rethrow error if shouldRethrow is true.
      if (shouldRethrow) {
        rethrow;
      }
    }
  }
}
