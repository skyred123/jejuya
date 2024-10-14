import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/media/media_loader.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// An enum representing the different tabs available in the bottom tab bar.
enum TabBarItem {
  /// Represents the "Profile" tab with its icon, selected icon, and label.
  home(
    icon: LocalSvgRes.home,
    selectedIcon: LocalSvgRes.home,
    label: 'bottom_tab_bar.label_profile',
  ),

  schedule(
    icon: LocalSvgRes.schedule,
    selectedIcon: LocalSvgRes.schedule,
    label: 'bottom_tab_bar.label_profile',
  ),

  favorite(
    icon: LocalSvgRes.like,
    selectedIcon: LocalSvgRes.like,
    label: 'bottom_tab_bar.label_notification',
  ),

  profile(
    icon: LocalSvgRes.schedule,
    selectedIcon: LocalSvgRes.schedule,
    label: 'bottom_tab_bar.label_profile',
  );

  /// Constructor to initialize the enum with associated properties.
  const TabBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  /// The icon displayed when the tab is not selected.
  final String icon;

  /// The icon displayed when the tab is selected.
  final String selectedIcon;

  /// The label displayed under the tab.
  final String label;
}

/// A custom BottomTabBar widget that displays the tab bar at the bottom.
class BottomTabBar extends StatelessWidget {
  /// The list of BottomTabBarItem widgets corresponding to the tabs.
  const BottomTabBar({super.key});

  /// The list of BottomTabBarItem widgets corresponding to the tabs.
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: context.width,
        height: 60.hMin,
        alignment: Alignment.center,
        child: const Row(
          children: [
            Expanded(
              child: BottomTabBarItem(tab: TabBarItem.home),
            ),
            Expanded(
              child: BottomTabBarItem(tab: TabBarItem.schedule),
            ),
            Expanded(
              child: BottomTabBarItem(tab: TabBarItem.favorite),
            ),
            Expanded(
              child: BottomTabBarItem(tab: TabBarItem.profile),
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom BottomTabBarItem widget representing an individual tab item.
class BottomTabBarItem extends StatelessWidget {
  /// Constructor for the BottomTabBarItem widget.
  const BottomTabBarItem({
    super.key,
    required this.tab,
  });

  /// The tab this item represents.
  final TabBarItem tab;

  @override
  Widget build(BuildContext context) {
    // Get the currently selected tab from the state.
    final selectedTab = context.watch<BottomTabBarState>().selectedTab;

    return IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      onPressed: () {
        context.read<BottomTabBarState>().changeTab(tab);
      },
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            firstChild: _iconTabBarItem(tab.icon),
            secondChild: _iconTabBarItem(tab.selectedIcon),
            crossFadeState: selectedTab != tab
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          CustomText(
            tr(tab.label),
            style: TextStyle(
              fontSize: 14.spMin,
              fontWeight: FontWeight.w500,
              color: selectedTab != tab
                  ? context.color.white
                  : context.color.primaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconTabBarItem(String url) => MediaLoader(
        url: url,
        fit: BoxFit.contain,
        width: 24.rMin,
        height: 24.rMin,
      );
}

/// State class to manage the state of the BottomTabBar widget.
class BottomTabBarState extends ChangeNotifier {
  /// The list of available tabs.

  /// The currently selected tab. Defaults to the boost tab.
  TabBarItem selectedTab = TabBarItem.home;

  /// The controller for the page view.
  PageController? _pageController;

  /// Attach the controller to the page view.
  void attachController(PageController controller) {
    if (_pageController != null && _pageController != controller) {
      _pageController?.dispose();
    }
    _pageController = controller;
  }

  /// Method to change the selected tab.
  void changeTab(TabBarItem newTab, {bool withoutJumpPage = false}) {
    selectedTab = newTab;
    notifyListeners();

    if (!withoutJumpPage) {
      _pageController?.jumpToPage(TabBarItem.values.indexOf(selectedTab));
    }
  }

  /// Method to handle page change events.
  /// Updates the selected tab based on the current page.
  void onChangedPage(int page) {
    if (page < 0 || page >= TabBarItem.values.length) {
      return;
    }
    selectedTab = TabBarItem.values[page];
    notifyListeners();
  }
}
