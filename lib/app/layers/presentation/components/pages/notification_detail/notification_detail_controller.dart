import 'dart:async';

import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/notification/notification.dart';
import 'package:jejuya/app/layers/domain/usecases/notification_detail/notification_detail_usecase.dart';
import 'package:jejuya/app/layers/presentation/components/pages/notification_detail/enum/notification_detail_state.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Notification detail page
class NotificationDetailController extends BaseController with UseCaseProvider {
  /// Default constructor for the NotificationDetailController.
  NotificationDetailController({
    required this.notificationId,
  }) {
    fetchNotificationDetail();
  }

  // --- Member Variables ---

  final num? notificationId;

  List<String> image = [
    "https://res.cloudinary.com/timeless/image/upload/social_monkee/backgrounds/custom_skins_bg.png",
    "https://res.cloudinary.com/timeless/image/upload/social_monkee/backgrounds/earn_quests_bg.png",
    "https://res.cloudinary.com/timeless/image/upload/social_monkee/backgrounds/spaces_bg.png",
    "https://res.cloudinary.com/timeless/image/upload/social_monkee/backgrounds/custom_skins_bg.png",
  ];

  // --- Computed Variables ---
  // --- State Variables ---

  final detail = listenableStatus<Notification?>(null);

  final isSelecting = listenableStatus<bool>(false);

  final selectedImages = listenable<List<int>>([]);

  final fetchDetailState =
      listenable<NotificationDetailState>(NotificationDetailState.none);
  // --- State Computed ---
  // --- Usecases ---

  late final _fetchNotificationDetail = usecase<NotificationDetailUseCase>();
  // --- Methods ---

  Future<void> fetchNotificationDetail() async {
    try {
      fetchDetailState.value = NotificationDetailState.loading;
      if (notificationId == null) return;
      await _fetchNotificationDetail
          .execute(
            NotificationDetailRequest(notificationId: notificationId),
          )
          .then((response) => response.notification)
          .assignTo(detail);
      fetchDetailState.value = NotificationDetailState.done;
    } catch (e, s) {
      log.error(
        '[NotificationDetailController] Failed to fetch detail:',
        error: e,
        stackTrace: s,
      );
      nav.showSnackBar(error: e);
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
