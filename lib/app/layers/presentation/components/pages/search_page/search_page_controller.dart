import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';

/// Controller for the Search page page
class SearchPageController extends BaseController with UseCaseProvider {
  /// Default constructor for the SearchPageController.
  SearchPageController();

  // --- Member Variables ---
  /// Search Controller
  final TextEditingController searchController = TextEditingController();
  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  @override
  FutureOr<void> onDispose() async {}
}
