import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/data/sources/local/model/notification/notification.dart';
import 'package:jejuya/app/layers/data/sources/network/app_api_service.dart';
import 'package:jejuya/app/layers/domain/repositories/notification_detail/notification_detail_repository.dart';
import 'package:jejuya/core/arch/data/network/api_service_provider.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';

/// Implementation of the [NotificationDetailRepository] interface.
class NotificationDetailRepositoryImpl extends NotificationDetailRepository
    with LocalStorageProvider, ApiServiceProvider {
  @override
  Future<Notification> fetchNotificationDetail(
    num? notificationId,
  ) async =>
      apiService<AppApiService>().fetchNotificationDetail(notificationId!);

  // @override
  // Future<DestinationDetail> fetchDestinationDetail(
  //   String? destinationDetailId,
  // ) async =>
  //     apiService<AppApiService>()
  //         .fetchDestinationDetail(destinationDetailId: destinationDetailId!);
}
