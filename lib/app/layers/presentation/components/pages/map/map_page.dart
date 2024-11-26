import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/map/map_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_search_bar.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Map feature
class MapPage extends StatefulWidget with ControllerProvider<MapController> {
  /// Default constructor for the MapPage.
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
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
          return Stack(
            children: [
              _myMap,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _searchBar,
                  SizedBox(
                    width: 80.wMin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _iconButton(LocalSvgRes.filter, () {
                          nav.showFilterSheet();
                        }),
                        _iconButton(LocalSvgRes.radius, () {
                          widget.controller(context).toggleRadiusSlider();
                        }).marginOnly(
                          top: 10.hMin,
                        ),
                        Observer(
                          builder: (_) {
                            final ctrl = widget.controller(context);
                            return ctrl.isRadiusSliderVisible.value
                                ? _radiusSlider
                                : const SizedBox();
                          },
                        ),
                      ],
                    ).paddingOnly(
                      left: 20.wMin,
                    ),
                  ),
                ],
              ).paddingSymmetric(
                horizontal: 20.wMin,
                vertical: 20.hMin,
              )
            ],
          );
        },
      );

  Widget get _myMap => Builder(
        builder: (context) {
          return Observer(
            builder: (_) => GoogleMap(
              initialCameraPosition:
                  widget.controller(context).initialCameraPosition,
              onMapCreated: widget.controller(context).onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              onCameraMove: widget.controller(context).onCameraMove,
              markers:
                  Set<Marker>.from(widget.controller(context).markers.value),
              circles: {
                Circle(
                  circleId: const CircleId('current_location_radius'),
                  center:
                      widget.controller(context).selectedMarkerPosition.value,
                  radius: widget.controller(context).radiusInMeters.value,
                  fillColor: Colors.blue.withValues(alpha: 0.3),
                  strokeColor: Colors.blue,
                  strokeWidth: 1,
                ),
              },
            ),
          );
        },
      );

  Widget get _searchBar => Builder(
        builder: (context) {
          final ctrl = widget.controller(context);
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                nav.toSearch();
              },
              child: IgnorePointer(
                child: CustomSearchBar(
                  editingController: ctrl.searchController,
                  hint: tr("map.search"),
                  color: context.color.primaryColor,
                  fontSize: 14.spMin,
                  suffixIcon: LocalSvgRes.search,
                ),
              ),
            ),
          );
        },
      );

  Widget _iconButton(String iconPath, VoidCallback onTap) => Builder(
        builder: (context) {
          return BouncesAnimatedButton(
            width: 40.rMin,
            height: 40.rMin,
            onPressed: onTap,
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
                iconPath,
                colorFilter: ColorFilter.mode(
                  context.color.primaryColor,
                  BlendMode.srcIn,
                ),
              ).paddingSymmetric(vertical: 8.hMin, horizontal: 10.wMin),
            ),
          );
        },
      );

  Widget get _radiusSlider => Observer(
        builder: (_) {
          final ctrl = widget.controller(context);
          return SizedBox(
            height: 300.hMin,
            child: RotatedBox(
              quarterTurns: 1, // Rotate 90 degrees clockwise, min at top
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  // Make the track (body) thicker
                  trackHeight: 8.0,

                  // Color for the active part of the track
                  activeTrackColor: context.color.primaryLight,

                  // Color for the inactive part of the track
                  inactiveTrackColor: Colors.white,

                  // Color of the thumb (handle)
                  thumbColor: context.color.primaryColor,

                  // Label color
                  valueIndicatorColor: context.color.primaryColor,

                  // Label text style
                  valueIndicatorTextStyle: const TextStyle(
                    color: Colors.white,
                  ),

                  // Label style
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),

                  // Always show the label
                  showValueIndicator: ShowValueIndicator.always,

                  // Make the thumb larger
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 12.0,
                  ),

                  // Customize the tick mark shape for divisions
                  tickMarkShape: const RoundSliderTickMarkShape(),

                  // Color of active divisions
                  activeTickMarkColor: context.color.primaryLight,

                  // Color of inactive divisions
                  inactiveTickMarkColor: context.color.primaryLight,
                ),
                child: Slider(
                  value: ctrl.radiusInMeters.value,
                  min: 5000.0, // Minimum 5 km
                  max: 25000.0, // Maximum 25 km
                  divisions: 10,
                  label:
                      '${(ctrl.radiusInMeters.value / 1000).toStringAsFixed(1)} km',
                  onChanged: (value) {
                    ctrl.setRadius(value);
                  },
                ),
              ),
            ),
          );
        },
      );
}
