import 'package:flutter/material.dart';
import 'package:jejuya/app/layers/presentation/components/pages/splash/splash_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the splash feature
class SplashPage extends StatelessWidget
    with ControllerProvider<SplashController> {
  /// Default constructor
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller(context).syncAppState();
    });
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Splash Page'),
        ),
      ),
    );
  }
}
