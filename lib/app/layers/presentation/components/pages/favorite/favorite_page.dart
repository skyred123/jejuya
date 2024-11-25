import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:jejuya/app/common/ui/image/image_remote.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/favorite/favorite_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/dialog/custom_dialog.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/dialog/dialog_type_enum.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_search_bar.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Page widget for the Favorite feature
class FavoritePage extends StatelessWidget
    with ControllerProvider<FavoriteController> {
  /// Default constructor for the FavoritePage.
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
    );
  }

  Widget get _body => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Column(
            children: [
              _headerText,
              _searchBar,
              _navList,
              ctrl.isDetination.value ? _listDestination : _listSchedule,
            ],
          ).paddingOnly(
            top: 20.wMin,
            bottom: 15.wMin,
            left: 20.wMin,
            right: 20.wMin,
          );
        },
      );

  Widget get _navList => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => ctrl.isDetination.value = false,
                child: Container(
                  decoration: BoxDecoration(
                    color: !ctrl.isDetination.value
                        ? context.color.primaryColor
                        : context.color.white,
                    borderRadius: BorderRadius.circular(50.rMin),
                    border: Border.all(color: context.color.primaryColor),
                  ),
                  child: Text(
                    tr("favorite.schedule"),
                    style: TextStyle(
                      fontSize: 12.spMin,
                      color: ctrl.isDetination.value
                          ? context.color.primaryColor
                          : context.color.white,
                    ),
                  ).paddingSymmetric(horizontal: 20.wMin, vertical: 5.hMin),
                ),
              ).paddingOnly(right: 10.wMin),
              GestureDetector(
                onTap: () => ctrl.isDetination.value = true,
                child: Container(
                  decoration: BoxDecoration(
                    color: ctrl.isDetination.value
                        ? context.color.primaryColor
                        : context.color.white,
                    borderRadius: BorderRadius.circular(50.rMin),
                    border: Border.all(color: context.color.primaryColor),
                  ),
                  child: Text(
                    tr("favorite.destination"),
                    style: TextStyle(
                      fontSize: 12.spMin,
                      color: !ctrl.isDetination.value
                          ? context.color.primaryColor
                          : context.color.white,
                    ),
                  ).paddingSymmetric(horizontal: 20.wMin, vertical: 5.hMin),
                ),
              ),
            ],
          );
        },
      ).paddingOnly(bottom: 15.hMin);

  Widget get _headerText => Builder(
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  tr("favorite.favorite_list"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.spMin,
                    color: context.color.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              BouncesAnimatedButton(
                width: 34.rMin,
                height: 34.rMin,
                leading: Container(
                  decoration: BoxDecoration(
                    color: context.color.containerBackground,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.4),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: context.color.primaryColor,
                  ),
                ),
              )
            ],
          );
        },
      );

  Widget get _searchBar => Builder(
        builder: (context) {
          final ctrl = controller(context);
          return CustomSearchBar(
            editingController: ctrl.searchController,
            hint: tr("favorite.search"),
            color: context.color.primaryColor,
            fontSize: 14.spMin,
            suffixIcon: LocalSvgRes.search,
          ).paddingSymmetric(
            horizontal: 30.wMin,
            vertical: 16.hMin,
          );
        },
      );

  Widget get _listSchedule => Builder(
        builder: (context) {
          return Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return _scheduleItem(index);
              },
            ),
          );
        },
      );
  Widget get _listDestination => Builder(
        builder: (context) {
          return Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return _destinationItem(index);
              },
            ),
          );
        },
      );

  Widget _scheduleItem(int id) => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Dismissible(
            key: Key(id.toString()),
            background: Container(
              color: context.color.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20.wMin),
              child: SvgPicture.asset(
                LocalSvgRes.delete,
                colorFilter: ColorFilter.mode(
                  context.color.white2,
                  BlendMode.srcIn,
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              if (ctrl.notShowAgain.value) return true;
              final result = await _showDeleteDialog(context);
              final prefs = await SharedPreferences.getInstance();

              if (result != null) {
                bool confirmed = result['confirmed']!;
                bool isChecked = result['isChecked']!;

                if (isChecked) {
                  await prefs.setBool('notShowAgain', isChecked);
                }

                if (confirmed) {
                  return true;
                } else {
                  return false;
                }
              }
              return false;
            },
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item đã bị xóa'),
                ),
              );
            },
            child: BouncesAnimatedButton(
              width: context.width.hMin,
              height: 140.hMin,
              onPressed: () {/*nav.toScheduleDetail()*/},
              leading: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: context.color.primaryLight,
                      width: 5.0,
                    ),
                    top: BorderSide(
                      color: context.color.primaryLight,
                      width: 1.0,
                    ),
                    right: BorderSide(
                      color: context.color.primaryLight,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: context.color.primaryLight,
                      width: 1.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15.rMin),
                ),
                child: Center(
                  child: Row(
                    children: [
                      ImageNetwork(
                        image: RemoteImageRes.background,
                        height: 80.rMin,
                        width: 80.rMin,
                        duration: 1500,
                        curve: Curves.easeIn,
                        fitWeb: BoxFitWeb.cover,
                        onLoading: const CircularProgressIndicator(
                          color: Colors.indigoAccent,
                        ),
                        onError: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(15.rMin),
                      ).paddingOnly(right: 30.wMin),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                LocalSvgRes.schedule,
                                colorFilter: ColorFilter.mode(
                                  context.color.primaryLight,
                                  BlendMode.srcIn,
                                ),
                              ).paddingOnly(right: 10.wMin),
                              Text(
                                "12/10/2024 - 20/10/2024",
                                style: TextStyle(
                                  color: context.color.primaryLight,
                                  fontSize: 12.spMin,
                                ),
                              )
                            ],
                          ).paddingOnly(bottom: 10.hMin),
                          Text(
                            "Lịch trình 1",
                            style: TextStyle(
                              color: context.color.black,
                              fontSize: 12.spMin,
                            ),
                          ).paddingOnly(bottom: 10.hMin),
                          Text(
                            "Hotel Honey Crown",
                            style: TextStyle(
                              color: context.color.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.spMin,
                            ),
                          )
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 15.wMin, vertical: 20.hMin),
                ),
              ).paddingSymmetric(vertical: 10.hMin),
            ),
          );
        },
      );

  Widget _destinationItem(int id) => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Dismissible(
            key: Key(id.toString()),
            background: Container(
              color: context.color.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20.wMin),
              child: SvgPicture.asset(
                LocalSvgRes.delete,
                colorFilter: ColorFilter.mode(
                  context.color.white2,
                  BlendMode.srcIn,
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              if (ctrl.notShowAgain.value) return true;
              final result = await _showDeleteDialog(context);
              final prefs = await SharedPreferences.getInstance();

              if (result != null) {
                bool confirmed = result['confirmed']!;
                bool isChecked = result['isChecked']!;

                if (isChecked) {
                  await prefs.setBool('notShowAgain', isChecked);
                }

                if (confirmed) {
                  return true;
                } else {
                  return false;
                }
              }
              return false;
            },
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item đã bị xóa'),
                ),
              );
            },
            child: BouncesAnimatedButton(
              width: context.width.hMin,
              height: 140.hMin,
              // onPressed: () =>
              //     nav.toDestinationDetail(destinationId: id.toString()),
              leading: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: context.color.primaryLight,
                      width: 5.0,
                    ),
                    top: BorderSide(
                      color: context.color.primaryLight,
                      width: 1.0,
                    ),
                    right: BorderSide(
                      color: context.color.primaryLight,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: context.color.primaryLight,
                      width: 1.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15.rMin),
                ),
                child: Center(
                  child: Row(
                    children: [
                      ImageNetwork(
                        image: RemoteImageRes.background,
                        height: 80.rMin,
                        width: 80.rMin,
                        duration: 1500,
                        curve: Curves.easeIn,
                        fitWeb: BoxFitWeb.cover,
                        onLoading: const CircularProgressIndicator(
                          color: Colors.indigoAccent,
                        ),
                        onError: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(15.rMin),
                      ).paddingOnly(right: 30.wMin),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nohyung Supermarket",
                            style: TextStyle(
                              color: context.color.black,
                              fontSize: 12.spMin,
                              fontWeight: FontWeight.w600,
                            ),
                          ).paddingOnly(bottom: 10.hMin),
                          Row(
                            children: [
                              SvgPicture.asset(
                                LocalSvgRes.address,
                                colorFilter: ColorFilter.mode(
                                  context.color.primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ).paddingOnly(right: 7.hMin),
                              Text(
                                "98 Nohyeong-ro, Jeju-si",
                                style: TextStyle(
                                  fontSize: 12.spMin,
                                  color: context.color.black,
                                ),
                                textAlign: TextAlign.start,
                                softWrap: true,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 15.wMin, vertical: 20.hMin),
                ),
              ).paddingSymmetric(vertical: 10.hMin),
            ),
          );
        },
      );

  Future<Map<dynamic, dynamic>?> _showDeleteDialog(BuildContext context) async {
    return await showDialog<Map<dynamic, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          dialogType: DialogTypeEnum.delete,
        );
      },
    );
  }
}
