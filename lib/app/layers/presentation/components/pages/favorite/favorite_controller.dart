import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller for the Favorite page
class FavoriteController extends BaseController with UseCaseProvider {
  /// Default constructor for the FavoriteController.
  FavoriteController() {
    notShow();
  }

  // --- Member Variables ---

  /// Search Controller
  final TextEditingController searchController = TextEditingController();

  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  final notShowAgain = listenableStatus<bool>(false);

  final isDetination = listenableStatus<bool>(false);
  // --- Usecases ---
  // --- Methods ---

  Future<void> notShow() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getBool('notShowAgain') ?? false;
    notShowAgain.value = savedValue;
  }

  @override
  FutureOr<void> onDispose() async {}
}
