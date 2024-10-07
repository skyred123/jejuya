import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

/// A widget to calculate it's size after being built and attached
/// to a widget tree
/// [onChange] get changed [Size] of the Widget
/// [child] Widget to get size of it at runtime
class WidgetSize extends StatefulWidget {
  /// Default constructor for the WidgetSize
  const WidgetSize({
    required this.onChange,
    required this.child,
    super.key,
  });

  /// The child widget to be wrapped by the container.
  final Widget child;

  /// Callback to get the size of the widget
  final void Function(Size) onChange;

  @override
  State<WidgetSize> createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) {
    final context = widgetKey.currentContext;

    // Check if the view not yet attached to layout
    if (!mounted || context == null || context.size == null) return;

    final newSize = context.size!;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
