import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';
import 'package:jejuya/app/layers/domain/repositories/notification_detail/notification_detail_repository.dart';
import 'package:jejuya/app/layers/data/sources/local/model/notification/notification.dart';

/// Notification detail usecase
class NotificationDetailUseCase
    extends BaseUseCase<NotificationDetailRequest, NotificationDetailResponse>
    with RepositoryProvider {
  /// Default constructor for the NotificationDetailUseCase.
  NotificationDetailUseCase();

  @override
  Future<NotificationDetailResponse> execute(
      NotificationDetailRequest request) async {
    final notification = await repository<NotificationDetailRepository>()
        .fetchNotificationDetail(request.notificationId);
    return NotificationDetailResponse(notification: notification);
  }
}

/// Request for the Notification detail usecase
class NotificationDetailRequest {
  final num? notificationId;

  /// Default constructor for the NotificationDetailRequest.
  NotificationDetailRequest({required this.notificationId});
}

/// Response for the Notification detail usecase
class NotificationDetailResponse {
  final Notification notification;

  /// Default constructor for the NotificationDetailResponse.
  NotificationDetailResponse({required this.notification});
}
