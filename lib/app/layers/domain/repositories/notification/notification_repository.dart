import 'package:jejuya/core/arch/domain/repository/base_repository.dart';

import '../../../data/sources/local/model/notification/notification.dart';

/// Repository for the notification
abstract class NotificationRepository extends BaseRepository {
  /// Fetches a notifications.
  Future<List<Notification>> fetchNotifications(
    String? cursor,
  );

  /// Remove a notifications.
  Future<int> removeNotifications(
    int id,
  );
}
