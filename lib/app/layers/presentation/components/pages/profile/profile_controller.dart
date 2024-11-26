import 'dart:async';

import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the profile page
class ProfileController extends BaseController {
  /// Home controller constructor
  ProfileController();

  // --- Member Variables ---
  // --- Computed Variables ---
  // --- State Variables ---
  final isDetination = listenableStatus<bool>(true);

  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  @override
  FutureOr<void> onDispose() async {}
}
