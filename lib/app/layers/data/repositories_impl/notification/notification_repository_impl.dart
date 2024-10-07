import 'package:jejuya/app/layers/data/sources/local/model/notification/notification.dart';
import 'package:jejuya/app/layers/data/sources/network/app_api_service.dart';
import 'package:jejuya/app/layers/domain/repositories/notification/notification_repository.dart';
import 'package:jejuya/core/arch/data/network/api_service_provider.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';

/// Implementation of the [NotificationRepository] interface.
class NotificationRepositoryImpl extends NotificationRepository
    with LocalStorageProvider, ApiServiceProvider {
  @override
  Future<List<Notification>> fetchNotifications(
    String? cursor,
  ) async =>
      apiService<AppApiService>().fetchNotifications(cursor: cursor);

  @override
  Future<int> removeNotifications(int id) async =>
      apiService<AppApiService>().removeNotifications(id: id);
}
