import 'package:flutter/material.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule/schedule_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Schedule feature
class SchedulePage extends StatelessWidget
    with ControllerProvider<ScheduleController> {
  /// Default constructor for the SchedulePage.
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.shrink(),
      ),
    );
  }
}
