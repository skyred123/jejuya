import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';
import 'package:jejuya/app/common/utils/extension/widget/shimmer_animation.dart';

/// Placeholder type
enum PlaceholderType {
  /// Check in row placeholder
  checkInDays,

  /// Check in task placeholder
  checkInTask,

  /// Placeholder for complete task page
  completeTask,

  /// Placeholder for basic section list
  basicSectionList,

  /// Placeholder for the top carousel
  topCarousel,

  /// Placeholder for the header base detail page
  // text,

  ///Placeholder for the destination card
  destinationCard,

  ///Placeholder for the day card
  dayCard;
}

/// Placeholder widget
class PlaceholderWidget extends StatelessWidget {
  /// Default constructor for the PlaceholderWidget
  const PlaceholderWidget({
    required this.type,
    super.key,
  });

  /// Placeholder type
  final PlaceholderType type;

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (type) {
      case PlaceholderType.checkInDays:
        child = _checkInDays;
      case PlaceholderType.checkInTask:
        child = _checkInTask;
      case PlaceholderType.completeTask:
        child = _completeTask;
      case PlaceholderType.basicSectionList:
        child = _basicSectionList;
      case PlaceholderType.topCarousel:
        child = _topCarousel;
      case PlaceholderType.destinationCard:
        child = _destinationCard;
      case PlaceholderType.dayCard:
        child = _dayCard;
    }

    return child.shimmerAnimation.animate().fade();
  }
}

/// Placeholder widget common used extension
extension PlaceholderCommonUsedExt on PlaceholderWidget {
  /// Build rectangle
  Widget _buildRectangle({
    required double width,
    required double height,
    double? borderRadius,
    Color? color,
  }) =>
      Builder(
        builder: (context) {
          final bgColor = color ?? context.color.containerBackground;
          final radius = borderRadius ?? 16.rMin;

          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(radius),
            ),
          );
        },
      );

  Widget _buildCircle({
    required double diameter,
    Color? color,
  }) =>
      Builder(
        builder: (context) {
          final bgColor = color ?? context.color.containerBackground;
          return Container(
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(diameter / 2),
            ),
          );
        },
      );
}

/// Placeholder widget item extension
extension PlaceholderItem on PlaceholderWidget {
  Widget get _checkInDays => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          7,
          (_) => _buildCircle(diameter: 36.rMin),
        ),
      );

  Widget get _checkInTask => Builder(
        builder: (context) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: _buildRectangle(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 22.rMin,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.wMin),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: _buildRectangle(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 22.rMin,
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(
                top: 25.hMin,
                left: 15.wMin,
                right: 15.wMin,
              ),
              _buildRectangle(
                width: 131.wMin,
                height: 15.hMin,
                borderRadius: 7.5.rMin,
              ).paddingOnly(top: 10.hMin),
              _buildRectangle(
                width: double.infinity,
                height: 41.hMin,
                borderRadius: 20.5.rMin,
              ).paddingOnly(
                top: 8.hMin,
                bottom: 49.hMin,
                left: 45.wMin,
                right: 45.wMin,
              ),
            ],
          ).paddingOnly(top: 3.hMin, bottom: 3.hMin);
        },
      );

  Widget get _completeTask => Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRectangle(width: 225.wMin, height: 19.hMin),
              _buildRectangle(width: 225.wMin, height: 38.hMin),
            ],
          ),
          _buildRectangle(width: 130.wMin, height: 18.hMin)
              .paddingOnly(top: 41.hMin),
          _buildRectangle(width: 130.wMin, height: 34.hMin),
          _buildRectangle(width: double.infinity, height: 45.hMin)
              .paddingOnly(top: 13.hMin),
          _buildRectangle(width: 98.wMin, height: 20.hMin)
              .paddingOnly(top: 11.5.hMin),
        ],
      ).paddingOnly(top: 17.hMin, bottom: 17.hMin);

  Widget get _basicListItem => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRectangle(width: 150.wMin, height: 19.hMin)
              .paddingOnly(bottom: 5.hMin),
          _buildRectangle(width: 230.wMin, height: 16.hMin)
              .paddingOnly(bottom: 26.hMin),
          Row(
            children: [
              _buildRectangle(width: 85.wMin, height: 23.hMin)
                  .paddingOnly(right: 9.hMin),
              _buildRectangle(width: 50.wMin, height: 23.hMin),
            ],
          ),
        ],
      );

  Widget get _basicSectionList => Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRectangle(width: 150.wMin, height: 26.hMin),
              Column(
                children: [
                  _basicListItem.paddingOnly(bottom: 36.hMin),
                  _basicListItem.paddingOnly(bottom: 36.hMin),
                  _basicListItem,
                ],
              ).paddingOnly(top: 23.hMin).paddingSymmetric(horizontal: 18.wMin),
            ],
          ).paddingOnly(top: 33.hMin).paddingSymmetric(horizontal: 20.wMin),
        ],
      );

  Widget get _topCarouselItem => Builder(
        builder: (context) {
          return Stack(
            children: [
              _buildRectangle(
                width: context.width - 78.wMin,
                height: 57.hMin,
                color: Colors.black.withOpacity(0.4),
              ),
              Row(
                children: [
                  _buildCircle(
                    diameter: 37.rMin,
                  ).paddingOnly(right: 13.wMin),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRectangle(
                        width: 185.wMin,
                        height: 18.hMin,
                      ).paddingOnly(bottom: 5.wMin),
                      _buildRectangle(
                        width: 115.wMin,
                        height: 14.hMin,
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 13.wMin, vertical: 10.hMin),
            ],
          );
        },
      );

  Widget get _topCarousel => Builder(
        builder: (context) {
          return Row(
            children: [
              _topCarouselItem.paddingOnly(right: 8.wMin),
              _topCarouselItem.paddingOnly(right: 8.wMin),
              _topCarouselItem,
            ],
          ).paddingSymmetric(horizontal: 19.wMin);
        },
      );
  Widget get _destinationCard => Builder(
        builder: (context) {
          return Container(
            width: context.width,
            decoration: BoxDecoration(
              color: '#E1E1E1'.toColor,
              borderRadius: BorderRadius.circular(20.rMin),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRectangle(
                  height: 15.hMin,
                  width: 200.wMin,
                  borderRadius: 30.rMin,
                ).paddingAll(13.rMin),
                _buildRectangle(
                  height: 15.hMin,
                  width: 200.wMin,
                  borderRadius: 30.rMin,
                ).paddingAll(13.rMin),
                _buildRectangle(
                  height: 15.hMin,
                  width: 200.wMin,
                  borderRadius: 30.rMin,
                ).paddingAll(13.rMin),
              ],
            ),
          ).paddingSymmetric(horizontal: 10.rMin);
        },
      );
  Widget get _dayCard => Builder(
        builder: (context) {
          return _buildRectangle(
            height: 100.hMin,
            width: 70.wMin,
            borderRadius: 10.rMin,
            color: '#E1E1E1'.toColor,
          ).paddingSymmetric(horizontal: 10.rMin);
        },
      );
}
