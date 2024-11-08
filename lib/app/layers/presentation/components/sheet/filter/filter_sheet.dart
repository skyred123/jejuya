import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
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
                [
                  "A",
                  "B",
                  "C",
                  "D",
                  "E",
                  "F",
                  "G",
                  "H",
                  "I",
                  "J",
                  "K",
                  "L",
                  "M",
                  "N"
                ],
                ["O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"],
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
                    onPressed: () {},
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
                    onPressed: () {},
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

                // GridView.builder for the items within each category
                LayoutBuilder(
                  builder: (context, constraints) {
                    double itemWidth = 50.wMin;
                    int crossAxisCount =
                        (constraints.maxWidth / itemWidth).floor();

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 8.hMin,
                        crossAxisSpacing: 8.wMin,
                        childAspectRatio: 2,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return _categoryItem(categories[index]);
                      },
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
                width: 50.wMin,
                decoration: BoxDecoration(
                  color: controller.selectedCategories.contains(category)
                      ? context.color.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20.rMin),
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
                ),
              ),
            ),
          );
        },
      );
}
