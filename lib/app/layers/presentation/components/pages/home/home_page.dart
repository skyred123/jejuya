import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/home/home_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/keep_alive/keep_alive_page.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/tab_bar/bottom_tab_bar.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// Page widget for the home feature
class HomePage extends StatelessWidget with GlobalControllerProvider {
  /// Default constructor
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = globalController<HomeController>();

    final pageController = PageController(
      initialPage: ctrl.bottomTabBarState.selectedTab.index,
    );

    ctrl
      ..pageController = pageController
      ..bottomTabBarState.attachController(pageController);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: _tabBar,
          body: _pageView,
        ),
      ],
    );
  }

  Widget get _tabBar => Builder(
        builder: (context) {
          final ctrl = globalController<HomeController>();
          return ListenableProvider(
            key: const Key('bottom-tab-bar'),
            create: (_) => ctrl.bottomTabBarState,
            child: const BottomTabBar().marginAll(5.hMin),
          );
        },
      );

  Widget get _pageView => Builder(
        builder: (context) {
          final ctrl = globalController<HomeController>();
          return PageView(
            key: const Key('home-page-view'),
            controller: ctrl.pageController,
            onPageChanged: ctrl.bottomTabBarState.onChangedPage,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              KeepAlivePage(child: _profilePage),
              KeepAlivePage(child: _notificationPage),
            ],
          );
        },
      );

  Widget get _profilePage => nav.profile;
  Widget get _notificationPage => nav.notification;
}
