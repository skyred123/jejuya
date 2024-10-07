import 'dart:async';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/refreshable/smart_refresh_container.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';
import 'package:jejuya/core/reactive/obs_data.dart';

/// Controller for the smart refresh container view
class SmartRefreshController<T> extends BaseController {
  /// Default constructor
  SmartRefreshController({
    required this.tag,
    required this.loadData,
    this.filterData,
    this.onInitialized,
    this.onRefreshed,
    this.onStartRefreshing,
  }) {
    onRefresh();
    onInitialized?.call();
  }

  /// Tag for logging
  final String tag;

  /// Function to load data
  final Future<Pagination<T>> Function(String? cursor) loadData;

  /// Function to filter data
  final Future<List<T>> Function(List<T> items, String? keyword)? filterData;

  /// Callback when the controller is initialized
  final VoidCallback? onInitialized;

  /// Callback when the controller is started refreshing
  final VoidCallback? onStartRefreshing;

  /// Callback when the controller is refreshed
  final VoidCallback? onRefreshed;

  /// Operation to load data
  CancelableOperation<Pagination<T>>? _loadDataOperation;

  /// Result of the data
  final result = listenableStatus<Pagination<T>?>(null);

  /// Refresh controller
  final RefreshController refreshController = RefreshController();

  /// Next cursor
  String? nextCursor;

  /// State of the controller
  final state = listenable(SmartRefreshState.initial);

  /// Search result of the data after filtering with the keyword
  final filteredData = listenable<List<T>?>(null);

  /// Is search filtering
  late final isFiltering = listenableComputed(
    () => keyword.value.isBlank ?? true,
  );

  /// Search filter keyword
  final keyword = listenable<String?>(null);

  Future<bool?> _loadData({String? cursor}) async {
    final isLoadMore = cursor != null;

    if (isLoadMore && (result.isLoading || result.isLoadingMore)) {
      return null;
    }

    await _loadDataOperation?.cancel();

    try {
      _loadDataOperation = CancelableOperation.fromFuture(
        loadData.call(cursor),
      );
      await _loadDataOperation?.value.assignTo(
        result,
        loadingStatus: isLoadMore ? ObsDataStatus.loadingMore : null,
      );
      if (result.value?.items.isEmpty ?? true) {
        state.value = SmartRefreshState.empty;
      } else if (result.hasNextPage) {
        state.value = SmartRefreshState.loaded;
      } else {
        state.value = SmartRefreshState.finished;
      }
      nextCursor = result.value?.cursor;
      return result.hasNextPage;
    } catch (error, stackTrace) {
      log.error(
        '[$tag] Could not load data with cursor $cursor',
        error: error,
        stackTrace: stackTrace,
        sendToCrashlytics: true,
      );
      // await Future<void>.delayed(const Duration(milliseconds: 500));
      if (result.isEmpty) {
        state.value = SmartRefreshState.error;
      }
      rethrow;
    }
  }

  /// Refresh data
  Future<void> onRefresh() async {
    nextCursor = null;
    try {
      onStartRefreshing?.call();
      if (state.value == SmartRefreshState.error) {
        state.value = SmartRefreshState.loading;
      }
      final canLoadMore = await _loadData();
      await filter(keyword.value);
      refreshController.refreshCompleted();
      if (canLoadMore == null) return;
      if (canLoadMore) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
      onRefreshed?.call();
    } catch (_) {
      refreshController.refreshToIdle();
    }
  }

  /// Load more data
  Future<void> onLoadMore() async {
    try {
      final canLoadMore = await _loadData(cursor: nextCursor);
      await filter(keyword.value);
      if (canLoadMore == null) return;
      if (canLoadMore) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } catch (_) {
      refreshController.loadFailed();
    }
  }

  /// Reset data and states
  Future<void> reset() async {
    result
      ..value = null
      ..status = ObsDataStatus.initial;
    refreshController
      ..refreshCompleted()
      ..loadComplete();
    state.value = SmartRefreshState.loading;
    keyword.value = null;
    await onRefresh();
  }

  /// Reset data and states
  Future<void> filter(String? keyword) async {
    this.keyword.value = keyword;
    if (this.keyword.value.isBlank ?? true) {
      filteredData.value = null;
      return;
    }
    filteredData.value =
        await filterData?.call(result.value?.items ?? [], this.keyword.value);
  }

  /// Refresh state
  void refreshState() {
    if (result.value != null) {
      result.reportChanged();
      if (result.value?.items.isEmpty ?? true) {
        state.value = SmartRefreshState.empty;
      } else if (result.hasNextPage) {
        state.value = SmartRefreshState.loaded;
      } else {
        state.value = SmartRefreshState.finished;
      }
    }
  }

  @override
  FutureOr<void> onDispose() async {
    refreshController.dispose();
  }
}
