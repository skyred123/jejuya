import 'dart:async';

import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:mobx/mobx.dart';

/// Controller for the Filter sheet
class FilterController extends BaseController with UseCaseProvider {
  /// Default constructor for the FilterController.
  FilterController();

  // --- Member Variables ---
  // --- Computed Variables ---
  // --- State Variables ---

  /// Chosen categories
  final selectedCategories = ObservableList<String>();
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  void toggleCategorySelection(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
