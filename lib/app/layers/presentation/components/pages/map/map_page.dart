import 'package:flutter/material.dart';
import 'package:jejuya/app/layers/presentation/components/pages/map/map_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Map feature
class MapPage extends StatelessWidget
    with ControllerProvider<MapController> {
  /// Default constructor for the MapPage.
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.shrink(),
      ),
    );
  }
}
