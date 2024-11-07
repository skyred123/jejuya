import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:jejuya/app/common/ui/image/image_remote.dart';
import 'package:jejuya/app/common/ui/svg/svg_local.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/common/utils/extension/string/string_to_color.dart';
import 'package:jejuya/app/layers/presentation/components/pages/search_page/search_page_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/text_field/custom_search_bar.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the Search page feature
class SearchPagePage extends StatelessWidget
    with ControllerProvider<SearchPageController> {
  /// Default constructor for the SearchPagePage.
  const SearchPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header,
            recentSearch,
            _searchItem,
          ],
        ).paddingSymmetric(
          vertical: 20.hMin,
          horizontal: 16.wMin,
        ),
      ),
    );
  }

  Widget get _header => Builder(
        builder: (context) {
          return Row(
            children: [
              BouncesAnimatedButton(
                width: 40.rMin,
                height: 40.rMin,
                leading: Icon(
                  Icons.arrow_back_ios,
                  color: context.color.primaryColor,
                ),
              ),
              Expanded(child: _searchBar),
            ],
          );
        },
      );

  Widget get _searchBar => Builder(
        builder: (context) {
          final ctrl = controller(context);
          return CustomSearchBar(
            editingController: ctrl.searchController,
            hint: "Tìm kiếm",
            color: context.color.primaryColor,
            fontSize: 14.spMin,
            suffixIcon: LocalSvgRes.search,
          ).paddingSymmetric(
            horizontal: 30.wMin,
            vertical: 16.hMin,
          );
        },
      );

  Widget get recentSearch => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tìm kiếm gần đây",
                style: TextStyle(
                  color: context.color.info,
                  fontSize: 14.spMin,
                ),
              ).paddingOnly(bottom: 10.hMin),
              SizedBox(
                height: 30.hMin,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return _recentSearchItem;
                  },
                ),
              ),
            ],
          );
        },
      );

  Widget get _recentSearchItem => Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: context.color.primaryColor,
              borderRadius: BorderRadius.circular(20.rMin),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hotel 1",
                  style: TextStyle(
                    fontSize: 12.spMin,
                    color: context.color.white,
                  ),
                ).paddingOnly(left: 5.wMin),
                BouncesAnimatedButton(
                  width: 20.rMin,
                  height: 20.rMin,
                  leading: Icon(
                    Icons.close,
                    size: 15.rMin,
                    color: context.color.white,
                  ),
                )
              ],
            ).paddingAll(8.rMin),
          ).paddingOnly(right: 5.wMin);
        },
      );

  Widget get _searchItem => Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: context.color.containerBackground,
              borderRadius: BorderRadius.circular(25.rMin),
            ),
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
                    Text(
                      'Hotel 1',
                      style: TextStyle(fontSize: 14.spMin),
                    ).paddingOnly(bottom: 5.hMin),
                    Text(
                      '789 ABCX Street, District 1, Ho Chi Minh City ',
                      style: TextStyle(
                          fontSize: 12.spMin, color: context.color.info),
                    ).paddingOnly(bottom: 5.hMin),
                    _iconText(LocalSvgRes.address, "1.0 km",
                            context.color.primaryColor)
                        .paddingOnly(bottom: 5.hMin),
                    _iconText(
                      LocalSvgRes.star,
                      "4.8/5.0",
                      "#FAAB00".toColor,
                    ),
                  ],
                )
              ],
            ).paddingAll(12.rMin),
          ).paddingOnly(top: 10.hMin);
        },
      );

  Widget _iconText(String image, String text, Color color) => Builder(
        builder: (context) {
          return Row(
            children: [
              SvgPicture.asset(
                height: 15.rMin,
                width: 15.rMin,
                image,
                colorFilter: ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                ),
              ).paddingOnly(right: 7.hMin),
              Text(
                text,
                style: TextStyle(
                  fontSize: 10.spMin,
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
