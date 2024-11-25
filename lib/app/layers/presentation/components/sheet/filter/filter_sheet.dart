import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/filter/enum/filter_categories.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/filter/filter_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/button/bounces_animated_button.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Sheet widget for the Filter feature
class FilterSheet extends StatefulWidget
    with ControllerProvider<FilterController> {
  /// Default constructor for the FilterSheet.
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _categoryList(
                FilterCategory.values.map((e) => e.label).toList(),
                FilterDetailedCategory.values.map((e) => e.label).toList(),
              ),
            ),

            // Buttons at the bottom
            Row(
              children: [
                Expanded(
                  child: BouncesAnimatedButton(
                    leading: const Text(
                      "Đặt lại",
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 30.hMin,
                    decoration: BoxDecoration(
                      color: context.color.red,
                      borderRadius: BorderRadius.circular(8.rMin),
                    ),
                    onPressed: () {
                      widget.controller(context).selectedCategories.clear();
                    },
                  ),
                ),
                SizedBox(width: 10.wMin),
                Expanded(
                  child: BouncesAnimatedButton(
                    leading: const Text(
                      "Áp dụng",
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 30.hMin,
                    decoration: BoxDecoration(
                      color: context.color.primaryColor,
                      borderRadius: BorderRadius.circular(8.rMin),
                    ),
                    onPressed: () async {
                      final destinations = await widget
                          .controller(context)
                          .fetchDestinationsByCategory();
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(
              vertical: 10.hMin,
              horizontal: 10.wMin,
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryList(
    List<String> categories,
    List<String> detailedCategories,
  ) =>
      Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: context.color.primaryColor,
                child: Text(
                  "Bộ Lọc",
                  style: TextStyle(
                    fontSize: 14.spMin,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.start,
                  softWrap: true,
                ).paddingSymmetric(vertical: 15.hMin, horizontal: 10.wMin),
              ),
              Column(
                children: [
                  _categoryCard("Danh mục", categories).paddingSymmetric(
                    vertical: 10.hMin,
                  ),
                  _categoryCard("Danh mục chi tiết", detailedCategories),
                ],
              ).paddingSymmetric(horizontal: 10.wMin)
            ],
          );
        },
      );

  Widget _categoryCard(String cardName, List<String> categories) => Builder(
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.wMin),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15.rMin),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardName,
                  style: TextStyle(
                    fontSize: 14.spMin,
                    color: context.color.black,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
                SizedBox(height: 10.hMin),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      spacing: 8.wMin,
                      runSpacing: 8.hMin,
                      children: categories
                          .map((category) => IntrinsicWidth(
                                child: SizedBox(
                                  child: _categoryItem(category),
                                ),
                              ))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );

  Widget _categoryItem(String category) => Builder(
        builder: (context) {
          final controller = widget.controller(context);

          return Observer(
            builder: (_) => GestureDetector(
              onTap: () {
                controller.toggleCategorySelection(category);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedCategories.contains(category)
                      ? context.color.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15.rMin),
                  border: Border.all(
                    color: context.color.primaryColor,
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 9.spMin,
                    color: controller.selectedCategories.contains(category)
                        ? Colors.white
                        : context.color.primaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ).paddingSymmetric(
                  horizontal: 10.wMin,
                  vertical: 8.hMin,
                ),
              ),
            ),
          );
        },
      );
}
