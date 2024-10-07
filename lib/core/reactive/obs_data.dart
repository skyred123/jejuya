import 'package:jejuya/core/reactive/simple_obs_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'obs_data.g.dart';

/// Enum representing the status of an [ObsData] instance.
enum ObsDataStatus {
  /// Indicates that the data has not been loaded yet.
  initial,

  /// Indicates that the data is currently being loaded.
  loading,

  /// Indicates that the data is currently being refreshed.
  refreshing,

  /// Indicates that the data is currently being loaded more.
  /// This is usually used in conjunction with pagination.
  loadingMore,

  /// Indicates that the data has been successfully loaded.
  success,

  /// Indicates that an error occurred while loading the data.
  error
}

/// A class that holds data and its status for use in reactive programming.
class ObsData<T> extends SimpleObsData<T> {
  /// Creates a new instance of [ObsData].
  ///
  /// The [initValue] parameter is optional and defaults to `null`.
  /// The [error] parameter is optional and defaults to `null`.
  /// The [status] parameter is optional and defaults
  /// to [ObsDataStatus.loading].
  /// The [context] parameter is optional and is used to specify the
  /// [ReactiveContext] in which the data will be observed.
  /// The [name] parameter is optional and is used to specify the name of the
  /// data for debugging purposes.
  ObsData({
    required super.initValue,
    dynamic error,
    ObsDataStatus status = ObsDataStatus.initial,
    super.context,
    super.name,
  })  : _status = Observable(
          status,
          context: context,
          name: name != null ? '${name}_status' : null,
        ),
        _error = Observable(
          error,
          context: context,
          name: name != null ? '${name}_error' : null,
        );

  /// The error that occurred while loading the data.
  final Observable<dynamic> _error;

  /// The status of the data held by this instance.
  final Observable<ObsDataStatus> _status;

  /// Sets the error that occurred while loading the data.
  set error(dynamic value) => runInAction(() => _error.value = value);

  /// Sets the status of the data held by this instance.
  set status(ObsDataStatus value) => runInAction(() => _status.value = value);

  /// Returns the error that occurred while loading the data.
  dynamic get error => _error.value;

  /// Returns the status of the data held by this instance.
  ObsDataStatus get status => _status.value;

  /// Returns `true` if the data is null or empty.
  bool get isEmpty =>
      value == null || (value is Iterable && (value! as Iterable).isEmpty);

  /// Returns `true` if the status is [ObsDataStatus.success].
  bool get isSuccessful => _status.value == ObsDataStatus.success;

  /// Returns `true` if the status is [ObsDataStatus.loading].
  bool get isLoading => _status.value == ObsDataStatus.loading;

  /// Returns `true` if the status is [ObsDataStatus.refreshing].
  bool get isRefreshing => _status.value == ObsDataStatus.refreshing;

  /// Returns `true` if the status is [ObsDataStatus.loadingMore].
  bool get isLoadingMore => _status.value == ObsDataStatus.loadingMore;

  /// Returns `true` if the status is [ObsDataStatus.initial].
  bool get isInitial => _status.value == ObsDataStatus.initial;

  /// Returns `true` if the status is [ObsDataStatus.error].
  bool get isError => _status.value == ObsDataStatus.error;

  /// Returns `true` if data is a [Pagination] and has more items.
  bool get hasNextPage =>
      (value is Pagination ? value as Pagination : null)?.cursor?.isNotEmpty ??
      false;

  @override
  void reset() => transaction(() {
        value = initValue;
        error = null;
        status = ObsDataStatus.initial;
      });
}

/// Represents a pagination response containing a list of items and a cursor.
@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  genericArgumentFactories: true,
)
class Pagination<T> {
  /// Constructs a PaginationResponse with the given [items] and [cursor].
  Pagination({
    required this.items,
    required this.cursor,
  });

  /// Constructs an empty PaginationResponse with no items and no next cursor.
  Pagination.empty()
      : items = [],
        cursor = null;

  /// Factory method to deserialize from JSON
  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginationFromJson(json, fromJsonT);

  /// Method to serialize to JSON
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationToJson(this, toJsonT);

  /// The list of items.
  final List<T> items;

  /// The cursor for the next page.
  final String? cursor;
}
