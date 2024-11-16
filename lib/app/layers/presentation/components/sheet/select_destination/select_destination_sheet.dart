import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_network/image_network.dart';
import 'package:jejuya/app/common/ui/image/image_remote.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/select_destination/select_destination_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_clickable_search_bar.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Sheet widget for the Select destination feature
class SelectDestinationSheet extends StatelessWidget
    with ControllerProvider<SelectDestinationController> {
  /// Default constructor for the SelectDestinationSheet.
  const SelectDestinationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final sheetHeight = 0.8 * MediaQuery.sizeOf(context).height;
    return Container(
      color: context.color.primaryBackground,
      height: sheetHeight,
      child: _body,
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return Column(
            children: [
              Row(
                children: [
                  _locationDisplay(
                    "Nohyung Supermarket",
                    "98 Nohyeong-ro, Jeju-si",
                  ),
                  SizedBox(width: 10.wMin),
                  BouncesAnimatedButton(
                    leading: const Text(
                      "Thêm",
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 30.hMin,
                    width: 80.wMin,
                    decoration: BoxDecoration(
                      color: context.color.primaryColor,
                      borderRadius: BorderRadius.circular(8.rMin),
                    ),
                    onPressed: () {},
                  ),
                ],
              ).paddingOnly(top: 25.hMin),
              _recommendations(
                [
                  "Nohyung Supermarket",
                  "Nohyung Supermarket",
                  "Nohyung Supermarket",
                ],
              ),
              _searchBar,
              _tags(["family", "friends", "shop"]),
              _myMap,
            ],
          );
        },
      ).paddingSymmetric(vertical: 10.hMin, horizontal: 10.wMin);

  Widget _locationDisplay(
    String name,
    String location,
  ) =>
      Builder(
        builder: (context) {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.rMin),
                border: Border.all(
                  color: context.color.primaryColor,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    LocalSvgRes.marker,
                    colorFilter: ColorFilter.mode(
                      context.color.primaryColor,
                      BlendMode.srcIn,
                    ),
                    height: 20.hMin,
                    width: 20.wMin,
                  ),
                  Column(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 12.spMin,
                          color: context.color.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                        softWrap: true,
                      ),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 12.spMin,
                          color: context.color.info,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.start,
                        softWrap: true,
                      ),
                    ],
                  ).paddingOnly(left: 10.wMin),
                ],
              ).paddingSymmetric(vertical: 10.hMin, horizontal: 5.wMin),
            ),
          );
        },
      );

  Widget _recommendations(List<String> locations) => Builder(
        builder: (context) {
          return SizedBox(
            height: 150.hMin,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return _recommendationItem(locations[index]);
              },
            ),
          );
        },
      );

  Widget _recommendationItem(String name) => Observer(
        builder: (context) {
          return Column(
            children: [
              Container(
                width: 90.wMin,
                decoration: BoxDecoration(
                  color: context.color.white,
                  borderRadius: BorderRadius.circular(12.rMin),
                  border: Border.all(
                    color: context.color.primaryColor,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _image,
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 12.spMin,
                        color: context.color.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ).paddingSymmetric(vertical: 5.hMin),
                  ],
                ).paddingSymmetric(vertical: 5.hMin),
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

  Widget get _image => Builder(
        builder: (context) {
          return ImageNetwork(
            image: RemoteImageRes.background,
            height: 70.hMin,
            width: 70.wMin,
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
            borderRadius: BorderRadius.circular(10.rMin),
          );
        },
      );

  Widget get _searchBar => Builder(
        builder: (context) {
          final ctrl = controller(context);
          return CustomClickableSearchBar(
            editingController: ctrl.searchController,
            hint: "Tìm kiếm",
            color: context.color.primaryColor,
            fontSize: 14.spMin,
            suffixIcon: LocalSvgRes.filter,
            onSuffixIconTap: () {
              nav.showFilterSheet();
            },
          );
        },
      );

  Widget _tags(List<String> tags) => Builder(
        builder: (context) {
          return SizedBox(
            height: 25.hMin,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return _tag(tags[index]);
              },
            ),
          ).paddingSymmetric(vertical: 10.hMin);
        },
      );

  Widget _tag(String name) => Builder(
        builder: (context) {
          return Stack(
            children: [
              Container(
                width: 50.wMin,
                decoration: BoxDecoration(
                  color: context.color.primaryColor,
                  borderRadius: BorderRadius.circular(10.rMin),
                  border: Border.all(
                    color: context.color.primaryColor,
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 9.spMin,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ).paddingSymmetric(horizontal: 5.wMin),
              Positioned(
                right: 2.wMin,
                child: SvgPicture.asset(
                  LocalSvgRes.cancel,
                ),
              ),
            ],
          );
        },
      );

  Widget get _myMap => Builder(
        builder: (context) {
          return Observer(
            builder: (_) => Expanded(
              child: GoogleMap(
                initialCameraPosition:
                    controller(context).initialCameraPosition,
                onMapCreated: controller(context).onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                markers: Set<Marker>.from(controller(context).markers),
                circles: {
                  Circle(
                    circleId: const CircleId('current_location_radius'),
                    center: controller(context).selectedMarkerPosition.value,
                    radius: controller(context).radiusInMeters.value,
                    fillColor: Colors.blue.withOpacity(0.3),
                    strokeColor: Colors.blue,
                    strokeWidth: 1,
                  ),
                },
              ),
            ),
          );
        },
      );
}
