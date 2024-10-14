import 'dart:async';

import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';

/// Controller for the Favorite page
class FavoriteController extends BaseController with UseCaseProvider {
  /// Default constructor for the FavoriteController.
  FavoriteController();

  // --- Member Variables ---
  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  @override
  FutureOr<void> onDispose() async {}
}
