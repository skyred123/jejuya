import 'package:flutter/material.dart';
import 'package:jejuya/app/layers/presentation/components/pages/favorite/favorite_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Favorite feature
class FavoritePage extends StatelessWidget
    with ControllerProvider<FavoriteController> {
  /// Default constructor for the FavoritePage.
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.shrink(),
      ),
    );
  }
}
