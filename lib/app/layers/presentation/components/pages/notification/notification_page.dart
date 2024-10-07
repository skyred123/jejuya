import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification/notification_controller.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/list/basic_list.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/list_item/basic_list_item.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:flutter/material.dart';

/// Page widget for the notification feature
class NotificationPage extends StatelessWidget
    with ControllerProvider<NotificationController> {
  /// Default constructor
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _mainContentBuilder,
      ),
    );
  }

  Widget get _mainContentBuilder => Builder(
        builder: (context) {
          final ctrl = controller(context);

          return BasicList(
            controller: ctrl.notificationRefreshController,
            itemBuilder: (_, item) => BasicListItem(
              item: item,
              onDismissed: (item) => ctrl.onPressRemoveNotification(
                id: item.id as int,
              ),
              onPressed: (item) {
                log.info('Notification item pressed: ${item.id}');
                nav.toNotificationDetail<void>(
                  notificationId: item.id,
                );
              },
            ),
          );
        },
      );
}
