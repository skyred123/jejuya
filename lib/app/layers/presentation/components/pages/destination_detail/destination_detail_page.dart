import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/ui/image/image_remote.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/pages/destination_detail/destination_detail_controller.dart';
import 'package:jejuya/app/layers/presentation/components/pages/destination_detail/enum/info_enum.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:image_network/image_network.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Page widget for the Destination detail feature
class DestinationDetailPage extends StatelessWidget
    with ControllerProvider<DestinationDetailController> {
  /// Default constructor for the DestinationDetailPage.
  const DestinationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
    );
  }

  Widget get _body => Builder(
        builder: (context) {
          return Stack(
            children: [
              Positioned(top: 0, child: _bgImage),
              _infoContainer.paddingOnly(top: context.height / 6),
            ],
          );
        },
      );

  Widget get _bgImage => Builder(
        builder: (context) {
          return ImageNetwork(
            image: RemoteImageRes.background,
            height: context.height / 5,
            width: context.width,
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
          );
        },
      );

  Widget get _infoContainer => Builder(
        builder: (context) {
          final categoryList =
              Category.values.map((item) => item.name).toList();
          final categoryDetailList =
              CategoryDetail.values.map((item) => item.name).toList();
          return Container(
            width: context.width,
            decoration: BoxDecoration(
              color: context.color.white,
              borderRadius: BorderRadius.circular(30.rMin),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _name,
                  _decription,
                  _info,
                  _category("Danh Mục", categoryList),
                  _category("Danh Mục Chi Tiết", categoryDetailList),
                  _image,
                  _reservationBtn
                ],
              ).paddingSymmetric(
                vertical: 20.hMin,
                horizontal: 16.wMin,
              ),
            ),
          );
        },
      );

  Widget get _name => Builder(
        builder: (context) {
          return Text(
            "Nohyung Supermarket",
            style: TextStyle(
              color: context.color.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      );

  Widget get _decription => Builder(
        builder: (context) {
          return Text(
            "Beyond the boundary between the everyday and the extraordinary, For Garden Door, the starting point of leaving for an unknown space.",
            style: TextStyle(
              color: context.color.info,
              fontSize: 12,
            ),
          ).paddingOnly(top: 10.hMin);
        },
      );

  Widget get _info => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thông Tin",
                style: TextStyle(
                  color: context.color.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(top: 10.hMin, bottom: 16.hMin),
              Container(
                decoration: BoxDecoration(
                  color: context.color.containerBackground,
                  borderRadius: BorderRadius.circular(15.rMin),
                ),
                child: ListView.builder(
                  itemCount: InfoEnum.values.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _infoItem(InfoEnum.values[index]);
                  },
                ).paddingOnly(
                  left: 10.wMin,
                  right: 10.wMin,
                  bottom: 16.hMin,
                  top: 6.hMin,
                ),
              ),
            ],
          );
        },
      );

  Widget _infoItem(InfoEnum item) => Builder(
        builder: (context) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                item.icon,
                width: 16.rMin,
                height: 16.rMin,
                colorFilter: ColorFilter.mode(
                  context.color.primaryColor,
                  BlendMode.srcIn,
                ),
              ).paddingOnly(right: 15.wMin, left: 10.wMin),
              Text(
                item.name,
                style: TextStyle(
                  color: context.color.black,
                  fontSize: 12,
                ),
              ),
            ],
          ).paddingOnly(top: 8.hMin);
        },
      );

  Widget _category(String name, List<String> list) => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: context.color.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(top: 10.hMin, bottom: 16.hMin),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: list.map((name) {
                  return _categoryItem(name);
                }).toList(),
              ),
            ],
          ).paddingOnly(top: 10.h);
        },
      );

  Widget _categoryItem(String name) => Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: context.color.primaryColor,
              borderRadius: BorderRadius.circular(11.rMin),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: context.color.white,
                fontSize: 12,
              ),
            ).paddingSymmetric(
              horizontal: 10.hMin,
              vertical: 6.wMin,
            ),
          );
        },
      );

  Widget get _image => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hình Ảnh",
                style: TextStyle(
                  color: context.color.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(top: 10.hMin, bottom: 16.hMin),
              SizedBox(
                height: 500,
                child: MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.rMin),
                          color: Colors.blue[(index % 9 + 1) * 100],
                        ),
                        height: (index % 5 + 1) * 50.0,
                      ).paddingAll(5.rMin);
                    }),
              ),
            ],
          );
        },
      );
  Widget get _reservationBtn => Builder(
        builder: (context) {
          return Column(
            children: [
              BouncesAnimatedButton(
                onPressed: () {},
                decoration: BoxDecoration(
                  color: context.color.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Text(
                  'Đặt chỗ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ).paddingOnly(top: 20.hMin),
            ],
          );
        },
      );
}
