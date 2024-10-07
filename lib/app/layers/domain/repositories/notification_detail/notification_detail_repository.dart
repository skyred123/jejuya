import 'package:jejuya/app/layers/data/sources/local/model/notification/notification.dart';
import 'package:jejuya/core/arch/domain/repository/base_repository.dart';

/// Repository for the notification_detail
abstract class NotificationDetailRepository extends BaseRepository {
  Future<Notification> fetchNotificationDetail(
    num? notificationId,
  );
}
