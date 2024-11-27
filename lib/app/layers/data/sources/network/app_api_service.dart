import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:jejuya/app/common/app_config.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/ls_key_predefined.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
// import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/app/layers/data/sources/local/model/hotel/hotel.dart';
import 'package:jejuya/app/layers/data/sources/local/model/notification/notification.dart';
import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule.dart';
import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule_item.dart';
import 'package:jejuya/app/layers/data/sources/local/model/user/user.dart';
import 'package:jejuya/app/layers/data/sources/local/model/userDetail/userDetail.dart';
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

  Future<List<Destination>> fetchNearbyDestinations({
    double? longitude,
    double? latitude,
    int? radius,
  });

  // Future<DestinationDetail> fetchDestinationDetail({String? id});

  Future<List<Destination>> searchDestination({String? search});

  Future<List<Destination>> fetchDestinationsByCategory({String? category});

  Future<void> createSchedule({
    String? name,
    String? accommodation,
    String? startDate,
    String? endDate,
    List<ScheduleItem>? listDestination,
  });
  
  Future<UserDetail> fetchUserDetail();

  Future<List<Hotel>> fetchHotels();
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

  Future<List<Destination>> fetchNearbyDestinations({
    double? longitude,
    double? latitude,
    int? radius,
  }) {
    return performGet(
      'tourist-spot/near',
      query: {
        'longitude': longitude,
        'latitude': latitude,
        'radius': radius,
      },
      decoder: (data) {
        // Check if the data is a Map and contains the 'data' key
        if (data is Map && data['data'] is List) {
          // Map the 'data' list into Destination objects
          return (data['data'] as List)
              .map((item) => Destination.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format: data is not a list.');
        }
      },
    );
  }

  // @override
  // Future<DestinationDetail> fetchDestinationDetail({String? id}) {
  //   return performGet(
  //     'tourist-spot/detail',
  //     query: {
  //       'id': id,
  //     },
  //     decoder: (data) {
  //       if (data is Map<String, dynamic>) {
  //         // Ensure the data is a map and parse it to a DestinationDetail
  //         return DestinationDetail.fromJson(data['data']);
  //       } else {
  //         throw Exception('Unexpected response format: expected a map.');
  //       }
  //     },
  //   );
  // }

  @override
  Future<List<Destination>> searchDestination({String? search}) {
    return performGet(
      'tourist-spot',
      query: {
        'search': search,
      },
      decoder: (data) {
        // Check if the data is a Map and contains the 'data' key
        if (data is Map && data['data'] is List) {
          // Map the 'data' list into Destination objects
          return (data['data'] as List)
              .map((item) => Destination.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format: data is not a list.');
        }
      },
    );
  }

  @override
  Future<List<Destination>> fetchDestinationsByCategory({String? category}) {
    return performGet(
      'tourist-spot/detail-category',
      query: {
        'category': category,
      },
      decoder: (data) {
        // Check if the data is a Map and contains the 'data' key
        if (data is Map && data['data'] is List) {
          // Map the 'data' list into Destination objects
          return (data['data'] as List)
              .map((item) => Destination.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format: data is not a list.');
        }
      },
    );
  }

  @override
  Future<void> createSchedule({
    String? name,
    String? accommodation,
    String? startDate,
    String? endDate,
    List<ScheduleItem>? listDestination,
  }) async {
    String? token =
        "${await fba.FirebaseAuth.instance.currentUser?.getIdToken()}";
    final authHeader = {'Authorization': 'Bearer $token'};

    final requestBody = {
      'name': name,
      'accommodation': accommodation,
      'startDate': startDate,
      'endDate': endDate,
      'listDestination': listDestination,
    };

    final requestBodyJson = jsonEncode(requestBody);
    print("$requestBodyJson");
    return performPost(
      'user/schedule/create',
      requestBody,
      headers: authHeader,
      decoder: (data) {
        print(data['messageEnglish']);
        nav.showSnackBar(message: data['messageEnglish']);
      },
    );
  }

  @override        
  Future<UserDetail> fetchUserDetail() async {
    String? token =
        "${await fba.FirebaseAuth.instance.currentUser?.getIdToken()}";
    // print(token);
    final authHeader = {'Authorization': 'Bearer $token'};
    return performGet(
      'user/detail',
      headers: authHeader,
      decoder: (data) {
        //print(data['data']);
        UserDetail userDetail =
            UserDetail.fromJson(data['data'] as Map<String, dynamic>);
        return userDetail;
      },
    );
  }

  @override
  Future<List<Hotel>> fetchHotels() {
    return performGet(
      'hotel/all',
      decoder: (data) {
        // Check if the data is a Map and contains the 'data' key
        if (data is Map && data['data'] is List) {
          // Map the 'data' list into Destination objects
          return (data['data'] as List)
              .map((item) => Hotel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format: data is not a list.');
        }
      },
    );
  }
}
