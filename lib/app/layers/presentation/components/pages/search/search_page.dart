import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/common/utils/location/location_utils.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/presentation/components/pages/search/search_controller.dart'
    as JejuyaSearch;
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_search_bar.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Search feature
class SearchPage extends StatelessWidget
    with ControllerProvider<JejuyaSearch.SearchController> {
  /// Default constructor for the SearchPage.
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _searchBar.paddingSymmetric(
              vertical: 10.hMin,
              horizontal: 10.wMin,
            ),
            Observer(builder: (context) {
              return Expanded(
                child: ListView.builder(
                    itemCount: ctrl.searchResults.value.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final destinationDetail =
                              await ctrl.fetchDestinationDetail(
                                  ctrl.searchResults.value[index].id);
                          nav.toDestinationDetail(
                              destinationId:
                                  ctrl.searchResults.value[index].id);
                        },
                        child: _searchItem(ctrl.searchResults.value[index])
                            .paddingSymmetric(
                          vertical: 10.hMin,
                          horizontal: 10.wMin,
                        ),
                      );
                    }),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget get _searchBar => Builder(
        builder: (context) {
          final ctrl = controller(context);
          return CustomSearchBar(
            editingController: ctrl.searchController,
            hint: "Tìm kiếm",
            color: context.color.primaryColor,
            fontSize: 14.spMin,
            suffixIcon: LocalSvgRes.search,
            onChanged: ctrl.onSearchTextChanged,
          );
        },
      );

  Widget _searchItem(Destination destination) => Builder(builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: context.color.containerBackground,
            borderRadius: BorderRadius.circular(10.rMin),
          ),
          child: Row(
            children: [
              ImageNetwork(
                image:
                    "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${Uri.encodeComponent(destination.businessNameEnglish)}&key=${dotenv.env['GOOGLE_MAP']}",
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
              ).paddingSymmetric(
                vertical: 10.hMin,
                horizontal: 10.wMin,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.businessNameEnglish,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14.spMin,
                        color: context.color.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    FutureBuilder(
                      future: LocationUtils.getDistanceFromCurrentLocation(
                          double.parse(destination.latitude),
                          double.parse(destination.longitude)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return _iconText(
                            LocalSvgRes.marker,
                            '${snapshot.data!.toStringAsFixed(1)} km',
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });

  Widget _iconText(String image, String text) => Builder(
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
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.spMin,
                  color: context.color.black,
                ),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ],
          );
        },
      );
}
