import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/home/home_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/keep_alive/keep_alive_page.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Page widget for the home feature
class HomePage extends StatelessWidget with GlobalControllerProvider {
  /// Default constructor
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = globalController<HomeController>();

    final pageController = PageController(
        //initialPage: ctrl.bottomTabBarState.selectedTab.index,
        initialPage: 0);

    ctrl
      ..pageController = pageController
      ..bottomTabBarState.attachController(pageController);

    ctrl.tabBarIndex.value = 0;

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              _pageView,
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _tabBar,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _tabBar => Observer(
        builder: (context) {
          final ctrl = globalController<HomeController>();
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.rMin),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3)),
              ],
            ),
            child: GNav(
              gap: 8,
              color: Colors.grey,
              activeColor: Colors.white,
              tabBackgroundColor: context.color.primaryColor,
              padding: const EdgeInsets.all(6),
              textSize: 12.spMin,
              textStyle: TextStyle(
                fontWeight: FontWeight.w300,
                color: context.color.white,
              ),
              tabs: [
                GButton(
                  icon: Icons.home,
                  leading: SvgPicture.asset(
                    LocalSvgRes.home,
                    width: 20.rMin,
                    height: 20.rMin,
                    colorFilter: ColorFilter.mode(
                      ctrl.tabBarIndex.value == 0 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: tr("home.home"),
                ),
                GButton(
                  icon: Icons.heat_pump_rounded,
                  leading: SvgPicture.asset(
                    LocalSvgRes.schedule,
                    width: 20.rMin,
                    height: 20.rMin,
                    colorFilter: ColorFilter.mode(
                      ctrl.tabBarIndex.value == 1 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: tr("home.schedule"),
                ),
                GButton(
                  icon: Icons.search,
                  leading: SvgPicture.asset(
                    LocalSvgRes.like,
                    width: 20.rMin,
                    height: 20.rMin,
                    colorFilter: ColorFilter.mode(
                      ctrl.tabBarIndex.value == 2 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: tr("home.favorite"),
                ),
                GButton(
                  icon: Icons.star,
                  leading: SvgPicture.asset(
                    LocalSvgRes.profile,
                    width: 20.rMin,
                    height: 20.rMin,
                    colorFilter: ColorFilter.mode(
                      ctrl.tabBarIndex.value == 3 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: tr("home.profile"),
                )
              ],
              onTabChange: (index) {
                ctrl.pageController?.jumpToPage(
                  index,
                );
                ctrl.bottomTabBarState.onChangedPage(index);
              },
            ).paddingSymmetric(vertical: 12.hMin, horizontal: 20.rMin),
          ).paddingOnly(bottom: 20.hMin, left: 16.hMin, right: 16.hMin);
        },
      );

  Widget get _pageView => Builder(
        builder: (context) {
          final ctrl = globalController<HomeController>();
          return PageView(
            key: const Key('home-page-view'),
            controller: ctrl.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              ctrl.bottomTabBarState.onChangedPage(index);
              ctrl.tabBarIndex.value = index;
            },
            children: [
              KeepAlivePage(child: _homePage),
              KeepAlivePage(child: _schedulePage),
              KeepAlivePage(child: _favoritePage),
              KeepAlivePage(child: _profilePage),
            ],
          );
        },
      );

  Widget get _homePage => nav.map;
  Widget get _schedulePage => nav.schedule;
  Widget get _favoritePage => nav.favorite;
  Widget get _profilePage => nav.profile;
}
