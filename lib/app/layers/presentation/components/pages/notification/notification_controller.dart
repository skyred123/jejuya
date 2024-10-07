import 'dart:async';

import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/domain/usecases/notification/fetch_notifications_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/notification/remove_notification_usecase.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/refreshable/smart_refresh_controller.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:jejuya/core/reactive/obs_data.dart';

/// Controller for the notification page
class NotificationController extends BaseController
    with GlobalControllerProvider, UseCaseProvider {
  /// Default constructor for the NotificationController.
  NotificationController();

  // --- Member Variables ---

  /// Initialize refresh controllers for managing pagination and data retrieval.
  late final notificationRefreshController = SmartRefreshController(
    tag: 'notificationRefreshController',
    loadData: (cursor) async => _fetchNotificationsUseCase
        .execute(FetchNotificationsRequest(cursor))
        .then(
          (response) => Pagination(
            items: response.notification,
            cursor: cursor,
          ),
        ),
  );

  // --- Usecases ---

  late final _fetchNotificationsUseCase = usecase<FetchNotificationsUseCase>();
  late final _removeNotificationUseCase = usecase<RemoveNotificationUseCase>();

  /// Functional refresh notifications.
  Future<void> handleRefreshNotifications() async =>
      notificationRefreshController.onRefresh();

  /// Functional refresh notifications.
  Future<void> onPressRemoveNotification({required int id}) async {
    try {
      final response = await _removeNotificationUseCase.execute(
        RemoveNotificationRequest(id),
      );

      notificationRefreshController.result.value?.items.removeWhere(
        (item) => item.id == response.id,
      );
    } catch (e, s) {
      log.error(
        '[NotificationController] Failed to remove item',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
    notificationRefreshController.result.reportChanged();
  }

  @override
  FutureOr<void> onDispose() async {}
}
