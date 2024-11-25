import 'dart:async';

import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_destination_by_category_usecase.dart';
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

  Future<List<Destination>> fetchDestinationsByCategory() async {
    try {
      final category = selectedCategories.join(',');

      final response = await GetDestinationByCategoryUsecase().execute(
        GetDestinationByCategoryRequest(category: category),
      );
      return response.destinations;
    } catch (e, s) {
      log.error('[MapController] Error fetching nearby destinations',
          error: e, stackTrace: s);
      return [];
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
