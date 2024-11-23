import 'package:jejuya/app/common/app_config.dart';
import 'package:jejuya/app/layers/data/sources/local/ls_key_predefined.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/data/sources/local/model/notification/notification.dart';
import 'package:jejuya/app/layers/data/sources/local/model/user/user.dart';
import 'package:jejuya/core/arch/data/network/base_api_service.dart';
import 'package:jejuya/core/reactive/obs_setting.dart';

/// API service for the application.
abstract class AppApiService extends BaseApiService {
  /// Login endpoint.
  Future<User> login();

  /// Notifications endpoint.
  Future<List<Notification>> fetchNotifications({
    String? cursor,
  });

  /// remove Notifications endpoint.
  Future<int> removeNotifications({
    int? id,
  });

  Future<Notification> fetchNotificationDetail(num? notificationId);

  Future<List<Destination>> recommendDestinations({
    double? longitude,
    double? latitude,
    int? radius,
    String? fromDate,
    String? toDate,
  });

  Future<DestinationDetail> fetchDestinationDetail({
    required String? destinationDetailId,
  });
}

/// Implementation of the [AppApiService] class.
class AppApiServiceImpl extends AppApiService {
  @override
  String get baseUrl => '${AppConfig.apiHost}/api/';
  // String get baseUrl => 'https://jsonplaceholder.typicode.com/';

  @override
  Map<String, String> get headers {
    final authToken =
        ObsSetting<User?>(key: LSKeyPredefinedExt.user, initValue: null)
            .value
            ?.token;
    final header = <String, String>{};

    if (authToken != null) {
      header['Authorization'] = 'Bearer $authToken';
    }
    return header;
  }

  @override
  Future<User> login() async {
    return performPost(
      'v1/login/',
      {},
      decoder: (data) => User.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<List<Notification>> fetchNotifications({
    String? cursor,
  }) {
    return performGet(
      'posts',
      query: {if (cursor != null) 'cursor': cursor},
      decoder: (data) => (data as List)
          .map((notification) => Notification.fromJson(
                notification as Map<String, dynamic>,
              ))
          .toList(),
    );
  }

  @override
  Future<int> removeNotifications({int? id}) {
    return performDelete(
      'posts/$id',
      decoder: (data) => id!,
    );
  }

  @override
  Future<Notification> fetchNotificationDetail(num? notificationId) {
    return performGet(
      'posts/$notificationId',
      decoder: (data) => Notification.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<List<Destination>> recommendDestinations({
    double? longitude,
    double? latitude,
    int? radius,
    String? fromDate,
    String? toDate,
  }) {
    return performPost(
      'tourist-spot/recommend',
      {
        'longitude': longitude,
        'latitude': latitude,
        'radius': radius,
        'fromDate': fromDate,
        'toDate': toDate,
      },
      decoder: (data) {
        if (data is Map<String, dynamic>) {
          var destinationsData = data['data'];

          if (destinationsData is List) {
            return destinationsData
                .map((destination) =>
                    Destination.fromJson(destination as Map<String, dynamic>))
                .toList();
          } else {
            throw Exception(
                'Unexpected response format: "data" is not a list.');
          }
        } else {
          throw Exception('Unexpected response format: expected a map.');
        }
      },
    );
  }

  @override
  Future<DestinationDetail> fetchDestinationDetail(
      {String? destinationDetailId}) {
    return performGet(
      'tourist-spot/detail?id=$destinationDetailId',
      // decoder: (data) =>
      //     DestinationDetail.fromJson(data as Map<String, dynamic>),
      decoder: (data) {
        return DestinationDetail.fromJson(data["data"] as Map<String, dynamic>);
      },
    );
  }
}
