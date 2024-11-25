import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/create_schedule_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/enum/create_schedule_state.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/enum/recommend_destination_state.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/enum/recommend_destination_state.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/placeholder_widget/placeholder_widget.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/placeholder_widget/placeholder_widget.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Create schedule feature
class CreateSchedulePage extends StatelessWidget
    with ControllerProvider<CreateScheduleController> {
  /// Default constructor for the CreateSchedulePage.
  const CreateSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _header.paddingSymmetric(
                vertical: 10.hMin,
                horizontal: 10.hMin,
              ),
            ),
            SliverToBoxAdapter(
              child: _infoDisplay.paddingSymmetric(
                horizontal: 10.wMin,
                vertical: 15.hMin,
              ),
            ),
            SliverToBoxAdapter(
              child: _listDay,
            ),
            _listDestination,
            SliverToBoxAdapter(
              child: Divider(
                thickness: 1.5,
                color: context.color.info,
              ).paddingSymmetric(
                horizontal: 30.wMin,
                vertical: 15.hMin,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                tr("create_schedule.add_new"),
                style: TextStyle(
                  fontSize: 14.spMin,
                  color: context.color.black,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SliverToBoxAdapter(
              child: _newDestinationField.paddingSymmetric(
                horizontal: 15.wMin,
                vertical: 15.hMin,
              ),
            ),
            SliverToBoxAdapter(
              child: _createBtn,
            )
          ],
        ),
      ),
    );
  }

  Widget get _header => Builder(builder: (context) {
        final ctrl = controller(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Text(
              tr("create_schedule.title"),
              style: TextStyle(
                fontSize: 20.spMin,
                color: context.color.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            BouncesAnimatedButton(
              onPressed: () => ctrl.fetchRecommendedDestinations(),
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
                  LocalSvgRes.generate,
                  colorFilter: ColorFilter.mode(
                    context.color.primaryColor,
                    BlendMode.srcIn,
                  ),
                ).paddingSymmetric(
                  vertical: 8.hMin,
                  horizontal: 10.wMin,
                ),
              ),
            ),
          ],
        );
      });

  Widget get _infoDisplay => Builder(builder: (context) {
        return Column(
          children: [
            _inputField(
              controller(context).nameController,
              tr("create_schedule.schedule_name"),
              context.color.info,
              1,
              12.spMin,
              LocalSvgRes.schedule,
            ),
            _inputField(
              controller(context).locationController,
              tr("create_schedule.accommodation"),
              context.color.info,
              1,
              12.spMin,
              LocalSvgRes.marker,
              isReadOnly: true,
              onTap: () {
                nav.showSelectDestinationSheet();
              },
            ).paddingSymmetric(vertical: 15.hMin),
            _inputField(
              controller(context).dateController,
              "07/04/2024 - 12/04/2024",
              context.color.info,
              1,
              12.spMin,
              LocalSvgRes.calendar,
              isReadOnly: true,
              onTap: () {
                controller(context).selectDates(context);
              },
            ),
          ],
        );
      });

  Widget _inputField(
    TextEditingController textEditingController,
    String hintText,
    Color color,
    double borderWidth,
    final double fontSize,
    String iconPath, {
    bool isReadOnly = false,
    VoidCallback? onTap,
  }) =>
      Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: const TextSelectionThemeData(
                selectionColor: Colors.transparent,
              ),
            ),
            child: TextField(
              controller: textEditingController,
              readOnly: isReadOnly,
              onTap: onTap ?? () {},
              decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: borderWidth.rMin,
                  ),
                  borderRadius: BorderRadius.circular(10.rMin),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: borderWidth.rMin,
                  ),
                  borderRadius: BorderRadius.circular(10.rMin),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.hMin,
                  horizontal: 10.wMin,
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: fontSize,
                ),
                prefixIcon: UnconstrainedBox(
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: ColorFilter.mode(
                      color,
                      BlendMode.srcIn,
                    ),
                    height: 20.hMin,
                    width: 20.wMin,
                  ),
                ),
              ),
              cursorColor: color,
              style: TextStyle(color: color, fontSize: fontSize),
            ),
          );
        },
      );

  Widget get _listDay => Observer(
        builder: (context) {
          final ctrl = controller(context);
          final listDay = ctrl.groupDestinationsByDate(ctrl.destinations.value);
          final dates = ctrl.extractDates(listDay);
          // final listDay = ctrl.schedules;
          return ctrl.fetchState.value == RecommendDestinationState.loading
              ? const PlaceholderWidget(type: PlaceholderType.dayCard)
              : SizedBox(
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
                        leading: _dayItem(dates[index], index),
                      );
                    },
                  ).paddingSymmetric(horizontal: 10.wMin),
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
          ).paddingOnly(
            right: 20.wMin,
            top: 10.hMin,
          );
        },
      );

  Widget get _listDestination => Builder(builder: (context) {
        return Observer(
          builder: (BuildContext context) {
            final ctrl = controller(context);
            final current =
                ctrl.extractDestinations(ctrl.selectedDayIndex.value);
            // final current =
            //     ctrl.schedules[ctrl.selectedDayIndex.value].locations;
            return ctrl.fetchState.value == RecommendDestinationState.loading
                ? SliverToBoxAdapter(
                    child: placeholder,
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Dismissible(
                        key: Key(current[index].id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.wMin),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          // Handle delete action
                          ctrl.deleteLocation(index);
                        },
                        child: GestureDetector(
                          child: _destinationItem(current[index], index)
                              .paddingSymmetric(horizontal: 15.wMin),
                        ),
                      ),
                      childCount: current.length,
                    ),
                  );
          },
        );
      });

  Widget _destinationItem(Destination destination, int index) => Observer(
        builder: (context) {
          return GestureDetector(
            onTap: () => nav.showDetinationInfoSheet(destination: destination),
            child: Container(
              decoration: BoxDecoration(
                color: context.color.white,
                borderRadius: BorderRadius.circular(20.rMin),
                border: Border(
                  top: BorderSide(width: 1, color: context.color.primaryLight),
                  left:
                      BorderSide(width: 13, color: context.color.primaryLight),
                  right:
                      BorderSide(width: 1, color: context.color.primaryLight),
                  bottom:
                      BorderSide(width: 1, color: context.color.primaryLight),
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
                          destination.businessNameEnglish,
                          true,
                        ).paddingOnly(
                          bottom: 16.hMin,
                        ),
                        _iconText(
                          LocalSvgRes.marker,
                          destination.businessNameEnglish,
                          false,
                        ).paddingOnly(
                          bottom: 16.hMin,
                        ),
                        _iconText(
                          LocalSvgRes.clock,
                          destination.startTime.toString(),
                          false,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          );
        },
      ).paddingSymmetric(vertical: 10.hMin);

  Widget get _destinationPlaceholer => Builder(
        builder: (context) {
          return Column(
            children: [
              const PlaceholderWidget(
                type: PlaceholderType.destinationCard,
              ).paddingSymmetric(
                vertical: 5.hMin,
              ),
              const PlaceholderWidget(
                type: PlaceholderType.destinationCard,
              ).paddingSymmetric(
                vertical: 5.hMin,
              ),
              const PlaceholderWidget(
                type: PlaceholderType.destinationCard,
              ).paddingSymmetric(
                vertical: 5.hMin,
              ),
            ],
          );
        },
      );

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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      );

  Widget get _newDestinationField => Builder(builder: (context) {
        return Column(
          children: [
            _inputField(
              controller(context).nameController,
              tr("create_schedule.accommodation"),
              context.color.info,
              1,
              12.spMin,
              LocalSvgRes.marker,
              isReadOnly: true,
              onTap: () {
                nav.showSelectDestinationSheet();
              },
            ),
            Row(
              children: [
                Expanded(
                  child: _inputField(
                    controller(context).timeStartController,
                    tr("create_schedule.start_time"),
                    context.color.info,
                    1,
                    12.spMin,
                    LocalSvgRes.time,
                    isReadOnly: true,
                    onTap: () {
                      controller(context).selectTime(context, true);
                    },
                  ),
                ),
                SizedBox(width: 10.wMin),
                Expanded(
                  child: _inputField(
                    controller(context).timeEndController,
                    tr("create_schedule.end_time"),
                    context.color.info,
                    1,
                    12.spMin,
                    LocalSvgRes.time,
                    isReadOnly: true,
                    onTap: () {
                      controller(context).selectTime(context, false);
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 15.hMin),
            _inputField(
              controller(context).nameController,
              tr("create_schedule.type"),
              context.color.info,
              1,
              12.spMin,
              LocalSvgRes.tag,
              isReadOnly: true,
            ),
          ],
        );
      });

  Widget get placeholder => Builder(
        builder: (context) {
          return Column(
            children: [
              const PlaceholderWidget(type: PlaceholderType.destinationCard)
                  .paddingSymmetric(vertical: 13.hMin),
              const PlaceholderWidget(type: PlaceholderType.destinationCard)
                  .paddingSymmetric(vertical: 13.hMin),
              const PlaceholderWidget(type: PlaceholderType.destinationCard)
                  .paddingSymmetric(vertical: 13.hMin),
            ],
          );
        },
      );

  Widget get _createBtn => Observer(builder: (context) {
        final ctrl = controller(context);
        return BouncesAnimatedButton(
          onPressed: () => ctrl.createSchedule(),
          height: 40.hMin,
          decoration: BoxDecoration(
            color: context.color.primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          leading: ctrl.createState.value == CreateScheduleState.loading
              ? SizedBox(
                  width: 20.rMin,
                  height: 20.rMin,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.color.white,
                    ),
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  tr("create_schedule.create_btn"),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
        ).paddingSymmetric(
          horizontal: 15.wMin,
          vertical: 10.hMin,
        );
      });
}
