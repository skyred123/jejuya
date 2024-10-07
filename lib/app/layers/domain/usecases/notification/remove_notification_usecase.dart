import 'package:jejuya/app/layers/domain/repositories/notification/notification_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

/// Remove notification usecase
class RemoveNotificationUseCase
    extends BaseUseCase<RemoveNotificationRequest, RemoveNotificationResponse>
    with RepositoryProvider {
  /// Default constructor for the RemoveNotificationUseCase.
  RemoveNotificationUseCase();

  @override
  Future<RemoveNotificationResponse> execute(
      RemoveNotificationRequest request) async {
    return repository<NotificationRepository>()
        .removeNotifications(request.id)
        .then(
          (id) => RemoveNotificationResponse(id: id),
        );
  }
}

/// Request for the Remove notification usecase
class RemoveNotificationRequest {
  /// Default constructor for the RemoveNotificationRequest.
  RemoveNotificationRequest(this.id);

  /// The id of item remove when the user clicked button remove.
  final int id;
}

/// Response for the Remove notification usecase
class RemoveNotificationResponse {
  /// Default constructor for the RemoveNotificationResponse.
  RemoveNotificationResponse({required this.id});

  /// The generated data based on the user remove.
  final int id;
}
