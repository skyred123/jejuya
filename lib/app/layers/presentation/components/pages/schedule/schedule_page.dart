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
import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule/schedule_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/dialog/custom_dialog.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/dialog/dialog_type_enum.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_search_bar.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Page widget for the Schedule feature
class SchedulePage extends StatelessWidget
    with ControllerProvider<ScheduleController> {
  /// Default constructor for the SchedulePage.
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller(context);
    print(ctrl.userDetail.value);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _body,
        ),
      ),
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return Column(
            children: [
              _headerText,
              _searchBar,
              _listSchedule,
            ],
          ).paddingOnly(
            top: 20.wMin,
            bottom: 15.wMin,
            left: 20.wMin,
            right: 20.wMin,
          );
        },
      );

  Widget get _headerText => Builder(
        builder: (context) {
          return Text(
            tr("schedule.schedule_list"),
            style: TextStyle(
              fontSize: 22.spMin,
              color: context.color.black,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      );

  Widget get _searchBar => Builder(
        builder: (context) {
          final ctrl = controller(context);
          return CustomSearchBar(
            editingController: ctrl.searchController,
            hint: tr("schedule.search"),
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
          final ctrl = controller(context);
          List<Schedule> schedules = ctrl.userDetail.value?.schedules ?? [];
          return Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return _scheduleItem(index);
              },
            ),
          );
        },
      );

  Widget _scheduleItem(int id) => Observer(
        builder: (context) {
          final ctrl = controller(context);
          String? formattedStartTime =
              ctrl.userDetail.value?.schedules?[id].startTime != null
                  ? DateFormat('dd/MM/yyyy').format(DateTime.parse(ctrl
                          .userDetail.value?.schedules?[id].startTime!
                          .toString() ??
                      ''))
                  : null;

          String? formattedEndTime =
              ctrl.userDetail.value?.schedules?[id].startTime != null
                  ? DateFormat('dd/MM/yyyy').format(DateTime.parse(ctrl
                          .userDetail.value?.schedules?[id].endTime!
                          .toString() ??
                      ''))
                  : null;
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
              onPressed: () {
                //print(ctrl.userDetail.value?.schedules?[id]);
                nav.toScheduleDetail(
                    scheduleId: ctrl.userDetail.value?.schedules?[id].id ?? '');
              },
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
                                "${formattedStartTime} - ${formattedEndTime} ",
                                // "${ctrl.userDetail.value?.schedules?[id].startTime.toString()} - ${ctrl.userDetail.value?.schedules?[id].endTime.toString()} ",
                                style: TextStyle(
                                  color: context.color.primaryLight,
                                  fontSize: 12.spMin,
                                ),
                              )
                            ],
                          ).paddingOnly(bottom: 10.hMin),
                          Text(
                            ctrl.userDetail.value?.schedules?[id].name ?? '',
                            style: TextStyle(
                              color: context.color.black,
                              fontSize: 12.spMin,
                            ),
                          ).paddingOnly(bottom: 10.hMin),
                          Text(
                            ctrl.userDetail.value?.schedules?[id]
                                    .accommodation ??
                                '',
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
