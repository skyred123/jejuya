import 'dart:async';

import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Controller for the profile page
class ProfileController extends BaseController with GlobalControllerProvider {
  /// Home controller constructor
  ProfileController();

  @override
  FutureOr<void> onDispose() async {}
}
