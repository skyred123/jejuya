import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/container/container_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// A wrapper widget for a bottom sheet.
/// This widget is used to wrap the content of a bottom sheet
/// and provide additional functionality or styling.
class BottomSheetWrapper extends StatelessWidget {
  /// Default constructor.
  const BottomSheetWrapper({
    required this.child,
    super.key,
    this.isShowIndicator = true,
    this.backgroundColor,
    this.showFadeOnTop = false,
    this.showFadeOnBottom = false,
    this.isDynamicSheet = false,
    this.padding = EdgeInsets.zero,
  });

  /// Child widget.
  final Widget child;

  /// Whether to show the indicator.
  final bool isShowIndicator;

  /// The background color of the bottom sheet.
  final Color? backgroundColor;

  /// Whether to show the fade on top.
  final bool showFadeOnTop;

  /// Whether to show the fade on bottom.
  final bool showFadeOnBottom;

  /// Whether the sheet is dynamic height.
  final bool isDynamicSheet;

  /// The padding of the bottom sheet.
  final EdgeInsets? padding;

  static const double _cornerRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ContainerWrapper(
        backgroundColor: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_cornerRadius.rMin),
          topRight: Radius.circular(_cornerRadius.rMin),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_cornerRadius.rMin),
            topRight: Radius.circular(_cornerRadius.rMin),
          ),
          child: isDynamicSheet ? IntrinsicHeight(child: _content) : _content,
        ),
      ),
    );
  }

  Widget get _content {
    return Builder(
      builder: (context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: double.infinity,
              child: child,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    blurTopSheet(showFadeOnTop: showFadeOnTop),
                    if (isShowIndicator)
                      Container(
                        decoration: BoxDecoration(
                          color: context.color.black,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        width: 70.wMin,
                        height: 5.hMin,
                      ).marginOnly(top: 16.hMin),
                  ],
                ),
                blurBottomSheet(showFadeOnBottom: showFadeOnBottom),
              ],
            ),
          ],
        );
      },
    );
  }

  /// The blur effect on the top of the bottom sheet.
  Widget blurTopSheet({bool showFadeOnTop = false}) => Builder(
        builder: (context) {
          return Opacity(
            opacity: showFadeOnTop ? 1 : 0,
            child: IgnorePointer(
              child: Container(
                height: 42.hMin,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      backgroundColor ?? context.color.containerBackground,
                      (backgroundColor ?? context.color.containerBackground)
                          .withValues(alpha: 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                      0.4,
                      1,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

  /// The blur effect on the bottom of the bottom sheet.
  Widget blurBottomSheet({bool showFadeOnBottom = false}) => Builder(
        builder: (context) {
          return Opacity(
            opacity: showFadeOnBottom ? 1 : 0,
            child: IgnorePointer(
              child: Container(
                height: 42.hMin,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      backgroundColor ?? context.color.containerBackground,
                      (backgroundColor ?? context.color.containerBackground)
                          .withValues(alpha: 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [
                      0.4,
                      1,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}

/// The bottom sheet builder.
extension BottomSheetBuilderExt on BottomSheetWrapper {
  /// Builds the bottom sheet.
  static Widget build({
    required Widget child,
    bool isShowIndicator = true,
    Color? backgroundColor,
    double initialChildSize = 0.5,
    bool shouldCloseWhenDraggedFromTop = true,
    List<double>? snapSizes = const [0.5, 0.8],
    bool draggableSheetWithoutScrollWrapper = false,
    bool showFadeOnTop = false,
    bool showFadeOnBottom = false,
    bool isDynamicSheet = false,
    DraggableScrollableController? controller,
    EdgeInsets? padding,
  }) {
    if (isDynamicSheet) {
      return BottomSheetWrapper(
        backgroundColor: backgroundColor,
        isShowIndicator: isShowIndicator,
        showFadeOnTop: showFadeOnTop,
        showFadeOnBottom: showFadeOnBottom,
        isDynamicSheet: true,
        padding: padding,
        child: child,
      );
    }

    final dragableSheetState = DragableSheetState()
      ..currentExtend = initialChildSize;
    final maxExtend = snapSizes?.lastOrNull ?? 0.8;
    var isDismissed = false;
    return ListenableProvider(
      create: (_) => dragableSheetState,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          final dragableSheetState =
              notification.context.read<DragableSheetState>();

          if (notification.extent >= maxExtend * 0.9 &&
              !dragableSheetState.isSnapedToMax) {
            dragableSheetState.snappedTomax(maxExtend);
          }

          if (notification.extent <= 0.2 && !isDismissed) {
            isDismissed = true;
            nav.back<void>();
          }
          return false;
        },
        child: Builder(
          builder: (context) {
            final isSnapedToMax =
                context.watch<DragableSheetState>().isSnapedToMax;
            return DraggableScrollableSheet(
              initialChildSize: initialChildSize,
              minChildSize: 0,
              maxChildSize: maxExtend,
              snap: true,
              expand: false,
              controller: controller,
              snapSizes: isSnapedToMax &&
                      shouldCloseWhenDraggedFromTop &&
                      (snapSizes?.length ?? 0) > 1
                  ? [0]
                  : snapSizes,
              shouldCloseOnMinExtent: false,
              snapAnimationDuration: Duration(
                milliseconds: (350 * dragableSheetState.currentExtend).toInt(),
              ),
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return BottomSheetWrapper(
                  backgroundColor: backgroundColor,
                  isShowIndicator: isShowIndicator,
                  showFadeOnTop: showFadeOnTop,
                  showFadeOnBottom: showFadeOnBottom,
                  child: draggableSheetWithoutScrollWrapper
                      ? ListenableProvider(
                          create: (_) => scrollController,
                          child: child,
                        )
                      : SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          controller: scrollController,
                          child: child,
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// The state of the draggable sheet.
class DragableSheetState extends ChangeNotifier {
  /// Whether the sheet is snapped to max.
  bool isSnapedToMax = false;

  /// The current extend of the sheet.
  double currentExtend = 0;

  /// Sets the state to snapped to max.
  void snappedTomax(double currentExtend) {
    isSnapedToMax = true;
    this.currentExtend = currentExtend;
    notifyListeners();
  }
}
