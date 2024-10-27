import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/container/container_wrapper.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/refreshable/smart_refresh_controller.dart';

/// Represents the different states of a smart refresh container.
enum SmartRefreshState {
  /// The initial state, before any data has been loaded.
  initial,

  /// Data is currently being loaded.
  loading,

  /// No data was returned from the server.
  empty,

  /// An error occurred while loading data.
  error,

  /// Data has been loaded successfully.
  loaded,

  /// No more data can be loaded.
  finished,

  /// The state has been reset.
  reset,
}

/// Smart refresh container widget.
/// Showing a list of data in a smart way.
class SmartRefreshContainer<T> extends StatelessWidget {
  /// Default constructor
  const SmartRefreshContainer({
    required this.ctrl,
    required this.contentBuilder,
    this.filterContentBuilder,
    this.loadingMoreWidget = const Center(child: CupertinoActivityIndicator()),
    this.enableBottomSafeArea = true,
    this.allowRefresh = true,
    this.allowLoadMore = true,
    this.reverse = false,
    this.physics,
    super.key,
  });

  /// Controller for the smart refresh container
  final SmartRefreshController<T> ctrl;

  /// Loading more widget
  final Widget loadingMoreWidget;

  /// Content builder
  final Widget Function(List<T> data) contentBuilder;

  /// Filter content builder
  final Widget Function(List<T> data)? filterContentBuilder;

  /// Whether to enable bottom safe area
  final bool enableBottomSafeArea;

  /// Whether to allow refresh
  final bool allowRefresh;

  /// Whether to allow load more
  final bool allowLoadMore;

  /// Reverse
  final bool reverse;

  /// Physics
  final ScrollPhysics? physics;

  /// Default empty widget
  Widget get emptyWidget => Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                tr('smart_refresh.empty_description'),
                style: TextStyle(
                  color: context.color.black,
                  fontSize: 16.spMin,
                ),
              ),
            ],
          );
        },
      );

  /// Default error widget
  Widget get errorWidget => Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                tr('smart_refresh.error_description'),
                style: TextStyle(
                  color: context.color.black,
                  fontSize: 16.spMin,
                ),
              ).paddingOnly(bottom: 5.hMin),
              BouncesAnimatedButton(
                height: 30.hMin,
                width: 100.wMin,
                leading: ContainerWrapper(
                  alignment: Alignment.center,
                  borderRadius: BorderRadius.circular(21.rMin),
                  backgroundColor: context.color.containerBackground,
                  child: Text(
                    tr('smart_refresh.btn_try_again'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.color.black,
                      fontSize: 12.spMin,
                    ),
                  ),
                ),
                onPressed: ctrl.onRefresh,
              ),
            ],
          );
        },
      );

  /// Default loading widget
  Widget get loadingWidget => Container(
        alignment: Alignment.center,
        child: const CupertinoActivityIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    final extraBottom =
        enableBottomSafeArea ? context.mediaQuery.viewPadding.bottom : 0.0;
    return Observer(
      builder: (context) {
        return SmartRefresher(
          key: key ?? ValueKey(ctrl.tag),
          physics: physics,
          onLoading: ctrl.onLoadMore,
          onRefresh: ctrl.onRefresh,
          enablePullUp: allowLoadMore,
          enablePullDown: allowRefresh,
          reverse: reverse,
          footer: CustomFooter(
            height:
                (ctrl.state.value == SmartRefreshState.finished ? 0 : 60.hMin) +
                    extraBottom,
            builder: (BuildContext context, LoadStatus? mode) {
              Widget? body;
              if (mode == LoadStatus.loading) {
                body = loadingMoreWidget;
              } else if (mode == LoadStatus.failed) {
                body = Center(
                  child: Text(
                    'Could not load more. Please try again!',
                    style: TextStyle(
                      color: context.color.black.withValues(alpha: 0.6),
                    ),
                  ),
                );
              }
              final content = SizedBox(
                height: 60.hMin,
                child: body ?? const SizedBox.shrink(),
              );
              return content.marginOnly(
                bottom: extraBottom,
              );
            },
          ),
          controller: ctrl.refreshController,

          /// Shoult not wrap the content widget with any wrap to avoid
          /// SmartRefresher not able to detect scroll view type & leads to some
          /// issues like not able to scroll, not able to pull to refresh, etc.
          child: switch (ctrl.state.value) {
            SmartRefreshState.initial ||
            SmartRefreshState.loading =>
              loadingWidget.animate().fade(),
            SmartRefreshState.error => errorWidget.animate().fade(),
            SmartRefreshState.empty => emptyWidget.animate().fade(),
            _ => (ctrl.isFiltering.value && filterContentBuilder != null)
                ? filterContentBuilder!.call(ctrl.filteredData.value ?? [])
                : contentBuilder(ctrl.result.value?.items ?? []),
          },
        );
      },
    );
  }
}
