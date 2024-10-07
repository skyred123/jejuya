import 'package:flutter/material.dart';

/// A widget that keeps its child alive even when it is not visible.
///
/// This widget is used to wrap a child widget that needs to maintain its state
/// even when it is not currently visible on the screen. It extends the
/// [StatefulWidget] class and implements the [AutomaticKeepAliveClientMixin]
/// to ensure that the child widget's state is preserved.
class KeepAlivePage extends StatefulWidget {
  /// Default constructor for [KeepAlivePage].
  const KeepAlivePage({required this.child, super.key});

  /// The child widget to keep alive.
  final Widget child;

  @override
  KeepAlivePageState createState() => KeepAlivePageState();
}

/// The state for the [KeepAlivePage] widget.
///
/// This state class extends [State] and implements the
/// [AutomaticKeepAliveClientMixin] to ensure that the state of the child widget
/// is preserved even when it is not currently visible on the screen.
class KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Don't forget this
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
