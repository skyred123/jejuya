import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/language/language_supported.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/schedule_detail_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/setting/setting_controller.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Schedule detail feature
class ScheduleDetailPage extends StatelessWidget
    with
        ControllerProvider<ScheduleDetailController>,
        GlobalControllerProvider {
  /// Default constructor for the ScheduleDetailPage.
  const ScheduleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller(context);
    print(ctrl.scheduleId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _headerBtn,
          ),
          SliverToBoxAdapter(
            child: _headerTxt,
          ),
          SliverToBoxAdapter(
            child: _day,
          ),
          Observer(
            builder: (BuildContext context) {
              final ctrl = controller(context);
              final current =
                  ctrl.schedules[ctrl.selectedDayIndex.value].locations;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => BouncesAnimatedButton(
                    height: 168.hMin,
                    onPressed: () {
                      ctrl.selectedDestinationIndex.value = index;
                      //nav.showDetinationInfoSheet(location: current[index]);
                    },
                    leading: _destinationItem(current[index], index),
                  ),
                  childCount: current.length,
                ),
              );
            },
          ),
        ],
      ).paddingSymmetric(
        vertical: 10.hMin,
        horizontal: 16.wMin,
      ),
    );
  }

  Widget get _headerBtn => Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BouncesAnimatedButton(
                width: 30.rMin,
                height: 30.rMin,
                leading: IconButton(
                  onPressed: nav.back,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: context.color.primaryColor,
                  ),
                ),
              ),
              const Spacer(),
              BouncesAnimatedButton(
                width: 40.rMin,
                height: 40.rMin,
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    LocalSvgRes.copy,
                    colorFilter: ColorFilter.mode(
                      context.color.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ).paddingSymmetric(vertical: 8.hMin, horizontal: 10.wMin),
                ),
              ).paddingOnly(right: 10.rMin),
              BouncesAnimatedButton(
                width: 40.rMin,
                height: 40.rMin,
                onPressed: () {
                  nav.toCreateSchedule();
                },
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    LocalSvgRes.edit,
                    colorFilter: ColorFilter.mode(
                      context.color.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ).paddingSymmetric(vertical: 8.hMin, horizontal: 10.wMin),
                ),
              ),
            ],
          );
        },
      );

  Widget get _headerTxt => Builder(
        builder: (context) {
          return Center(
            child: Text(
              "Jeju-si Trip",
              style: TextStyle(
                fontSize: 20.spMin,
                color: context.color.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ).paddingOnly(top: 5.hMin, bottom: 10.hMin);

  Widget get _day => Observer(
        builder: (context) {
          final ctrl = controller(context);
          final listDay = ctrl.schedules;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${listDay.first.date} - ${listDay.last.date}",
                style: TextStyle(
                  fontSize: 14.spMin,
                  color: context.color.black,
                ),
              ),
              _listDay,
              _info,
            ],
          );
        },
      );

  Widget get _listDay => Observer(
        builder: (context) {
          final ctrl = controller(context);
          final listDay = ctrl.schedules;
          return SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: listDay.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return BouncesAnimatedButton(
                  width: 70.rMin,
                  height: 70.hMin,
                  onPressed: () {
                    ctrl.updateSelectedDay(index);
                  },
                  leading: _dayItem(listDay[index].date, index),
                );
              },
            ),
          );
        },
      );

  Widget _dayItem(String date, int index) => Observer(
        builder: (context) {
          final ctrl = controller(context);
          final formattedDay = ctrl.formatDate(date);
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: index != ctrl.selectedDayIndex.value
                      ? context.color.white
                      : context.color.primaryLight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12.rMin),
                  border: Border.all(
                    color: context.color.primaryColor,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDay['monthAb'] ?? '',
                      style: TextStyle(
                        fontSize: 12.spMin,
                        color: context.color.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      formattedDay['day'] ?? '',
                      style: TextStyle(
                        fontSize: 14.spMin,
                        color: context.color.black,
                      ),
                    ),
                    Text(
                      formattedDay['dayOfWeek'] ?? '',
                      style: TextStyle(
                        fontSize: 12.spMin,
                        color: context.color.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10.rMin, vertical: 5.hMin),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 5.rMin,
                    height: 5.rMin,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.color.primaryLight,
                    ),
                  ).paddingOnly(right: 5.hMin),
                  Container(
                    width: 5.rMin,
                    height: 5.rMin,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: '#C8D6F4'.toColor,
                    ),
                  ).paddingOnly(right: 5.hMin),
                  Container(
                    width: 5.rMin,
                    height: 5.rMin,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: '#FCA2A3'.toColor,
                    ),
                  ),
                ],
              ).paddingOnly(top: 4.hMin),
            ],
          ).paddingOnly(right: 20.wMin, top: 10.hMin);
        },
      );

  Widget get _info => Observer(
        builder: (context) {
          final ctrl = controller(context);
          final currentDate = ctrl.schedules[ctrl.selectedDayIndex.value].date;
          final formattedDay = ctrl.formatDate(currentDate);
          final settingCtrl = globalController<SettingController>();

          final dayRank = settingCtrl.language.value != LanguageSupported.korean
              ? "${tr("destination_detail.day")} ${ctrl.selectedDayIndex.value + 1}"
              : "${ctrl.selectedDayIndex.value + 1} ${tr("destination_detail.day")} ";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10.rMin,
                    height: 10.rMin,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.color.primaryLight,
                    ),
                  ).paddingOnly(right: 10.rMin, left: 2.rMin),
                  Expanded(
                    child: Text(
                      "$dayRank  - ${formattedDay['dayOfWeek']}, ${formattedDay['day']}/${formattedDay['month']}/${formattedDay['year']}",
                      style: TextStyle(
                        fontSize: 12.spMin,
                        color: context.color.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 5.hMin),
              _iconText(
                LocalSvgRes.marker,
                "10 Samseong-ro, Jeju-si (Idoil-dong)",
                true,
              ),
            ],
          );
        },
      );

  Widget _destinationItem(Location location, int index) => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return Container(
            decoration: BoxDecoration(
              color: ctrl.selectedDestinationIndex.value == index
                  ? context.color.primaryColor.withValues(alpha: 0.1)
                  : context.color.white,
              borderRadius: BorderRadius.circular(20.rMin),
              border: Border(
                top: BorderSide(width: 1, color: context.color.primaryLight),
                left: BorderSide(width: 13, color: context.color.primaryLight),
                right: BorderSide(width: 1, color: context.color.primaryLight),
                bottom: BorderSide(width: 1, color: context.color.primaryLight),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _iconText(
                        LocalSvgRes.node,
                        location.name,
                        true,
                      ).paddingOnly(
                        bottom: 16.hMin,
                      ),
                      _iconText(
                        LocalSvgRes.marker,
                        location.address,
                        false,
                      ).paddingOnly(
                        bottom: 16.hMin,
                      ),
                      _iconText(
                        LocalSvgRes.clock,
                        location.time,
                        false,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 31.rMin,
                      height: 31.rMin,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.rMin),
                        color:
                            context.color.primaryLight.withValues(alpha: 0.3),
                      ),
                      child: SvgPicture.asset(
                        LocalSvgRes.clock,
                        colorFilter: ColorFilter.mode(
                          context.color.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ).paddingAll(7.rMin),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.rMin),
                        color:
                            context.color.primaryLight.withValues(alpha: 0.3),
                      ),
                      child: Text(
                        "Experience",
                        style: TextStyle(
                          color: context.color.primaryColor,
                          fontSize: 12.spMin,
                        ),
                      ).paddingAll(5.rMin),
                    ).paddingOnly(top: 30.hMin),
                  ],
                )
              ],
            ).paddingOnly(
              left: 20.wMin,
              right: 10.wMin,
              top: 16.hMin,
              bottom: 16.hMin,
            ),
          );
        },
      ).paddingSymmetric(vertical: 10.hMin);

  Widget _iconText(String image, String text, bool isTitle) => Builder(
        builder: (context) {
          return Row(
            children: [
              SvgPicture.asset(
                image,
                colorFilter: ColorFilter.mode(
                  context.color.primaryColor,
                  BlendMode.srcIn,
                ),
              ).paddingOnly(right: 7.hMin),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14.spMin,
                    color: context.color.black,
                    fontWeight: isTitle ? FontWeight.normal : FontWeight.w300,
                  ),
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          );
        },
      );
}
