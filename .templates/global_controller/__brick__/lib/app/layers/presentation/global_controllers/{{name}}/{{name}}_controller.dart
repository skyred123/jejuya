import 'dart:async';

import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';

/// Controller for the global {{name.sentenceCase()}} state
class {{name.pascalCase()}}Controller extends BaseController with UseCaseProvider {
  /// Default constructor for the {{name.pascalCase()}}Controller.
  {{name.pascalCase()}}Controller();

  // --- Member Variables ---
  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  @override
  FutureOr<void> onDispose() async {}
}
