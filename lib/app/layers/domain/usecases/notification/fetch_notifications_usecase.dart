import 'package:jejuya/app/layers/domain/repositories/notification/notification_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

import '../../../data/sources/local/model/notification/notification.dart';

/// Fetch notifications usecase
class FetchNotificationsUseCase
    extends BaseUseCase<FetchNotificationsRequest, FetchNotificationsResponse>
    with RepositoryProvider {
  /// Default constructor for the FetchNotificationsUseCase.
  FetchNotificationsUseCase();

  @override
  Future<FetchNotificationsResponse> execute(
      FetchNotificationsRequest request) async {
    return repository<NotificationRepository>()
        .fetchNotifications(request.cursor)
        .then(
          (notification) =>
              FetchNotificationsResponse(notification: notification),
        );
  }
}

/// Request for the Fetch notifications usecase
class FetchNotificationsRequest {
  /// Default constructor for the FetchNotificationsRequest.
  FetchNotificationsRequest(this.cursor);

  /// The cursor to load data with pagination.
  final String? cursor;
}

/// Response for the Fetch notifications usecase
class FetchNotificationsResponse {
  /// Default constructor for the FetchNotificationsResponse.
  FetchNotificationsResponse({required this.notification});

  /// The generated data based on the user fetching.
  final List<Notification> notification;
}
