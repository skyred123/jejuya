import 'dart:async';
import 'package:jejuya/app/layers/presentation/components/widgets/tab_bar/bottom_tab_bar.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the home page
class HomeController extends BaseController with GlobalControllerProvider {
  /// Home controller constructor
  HomeController() {
    initializeo();
  }

  void initializeo() {
    return;
  }

  // --- Member Variables ---

  /// State management for the bottom tab bar in the home page.
  late final bottomTabBarState = BottomTabBarState();

  final tabBarIndex = listenable<int>(0);

  /// PageController to manage page transitions when a tab is selected.
  PageController? pageController;

  // --- Methods ---

  /// Request to change the selected tab.
  void changeTab(TabBarItem newTab, {bool withoutJumpPage = false}) {
    bottomTabBarState.changeTab(newTab, withoutJumpPage: withoutJumpPage);
  }

  @override
  FutureOr<void> onDispose() async {}
}
