import 'package:jejuya/app/layers/presentation/components/pages/profile/profile_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';

/// Page widget for the profile feature
class ProfilePage extends StatelessWidget
    with ControllerProvider<ProfileController> {
  /// Default constructor
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}
