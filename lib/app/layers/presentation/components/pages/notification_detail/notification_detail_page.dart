import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification_detail/enum/notification_detail_state.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/media/media_loader.dart';
import 'package:flutter/material.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification_detail/notification_detail_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';

/// Page widget for the Notification detail feature
class NotificationDetailPage extends StatelessWidget
    with ControllerProvider<NotificationDetailController> {
  /// Default constructor for the NotificationDetailPage.
  NotificationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _info,
            _selectButton,
            Expanded(child: _images),
          ],
        ).paddingAll(20.hMin),
      ),
    );
  }

  Widget get _info => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return ctrl.fetchDetailState.value == NotificationDetailState.done
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("${ctrl.detail.value!.title?.toUpperCase()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Text("${ctrl.detail.value?.body}")
                        .paddingOnly(top: 10.hMin),
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        },
      );

  Widget get _selectButton => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return ElevatedButton(
            onPressed: () {
              ctrl.isSelecting.value = !ctrl.isSelecting.value;
              if (!ctrl.isSelecting.value) {
                ctrl.selectedImages.value.clear();
              }
            },
            child: Text(ctrl.isSelecting.value ? "Unselect" : "Select"),
          );
        },
      );

  Widget get _images => Observer(
        builder: (context) {
          final ctrl = controller(context);
          return ListView.builder(
            itemCount: ctrl.image.length,
            itemBuilder: (context, index) {
              double imageWidth = context.width;
              final isSelected = ctrl.selectedImages.value.contains(index);
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        ctrl.selectedImages.value.remove(index);
                      } else {
                        ctrl.selectedImages.value.add(index);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                      ),
                      child: MediaLoader(
                        url: ctrl.image[index],
                        width: imageWidth,
                        height: 250.hMin,
                        fit: BoxFit.cover,
                      ),
                    ).paddingSymmetric(vertical: 12.hMin),
                  ),
                ],
              );
            },
          );
        },
      ).paddingOnly(top: 20.hMin);
}
