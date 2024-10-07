import 'package:jejuya/app/layers/presentation/components/widgets/refreshable/smart_refresh_container.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/refreshable/smart_refresh_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// The widget is a custom BasicList that can be used in the app.
class BasicList<T> extends StatelessWidget {
  /// Constructor for the widget.
  const BasicList({
    super.key,
    required this.controller,
    this.itemBuilder,
  });

  /// The [itemBuilder] widget.
  final Widget Function(BuildContext, T)? itemBuilder;

  /// The [controller] widget.
  final SmartRefreshController<T> controller;

  @override
  Widget build(BuildContext context) {
    return SmartRefreshContainer(
      ctrl: controller,
      key: ValueKey(controller.tag),
      contentBuilder: (items) {
        return ListView.builder(
          itemCount: items.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            if (itemBuilder == null) return const SizedBox.shrink();

            return itemBuilder!(context, items[index])
                .animate()
                .slide(
                  duration: Duration(milliseconds: 450 + index * 50),
                  curve: Curves.easeIn,
                  begin: const Offset(0, 0.05),
                  end: Offset.zero,
                )
                .fadeIn();
          },
        );
      },
    );
  }
}
