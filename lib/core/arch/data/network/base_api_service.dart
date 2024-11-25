import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:worker_manager/worker_manager.dart';

final _dio = dio.Dio(
  dio.BaseOptions(
    connectTimeout: 15.seconds,
    receiveTimeout: 120.seconds,
  ),
)
// Enable this if you want to log all requests and responses
// ..interceptors.add(
//     dio.LogInterceptor(
//       logPrint: (o) => log.verbose(o.toString()),
//     ),
//   );
    ;

/// An abstract class representing a base API service.
///
/// This class provides the base URL and headers for an API service.
abstract class BaseApiService {
  /// The base URL for the API service.
  String get baseUrl;

  /// The headers for the API service.
  Map<String, String> get headers;

  /// Method to make a GET request to the API service.
  Future<T> performGet<T>(
    String path, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    bool returnRedirectedUri = false,
    WorkPriority priority = WorkPriority.high,
    bool background = true,
  }) {
    final requestUrl = _requestUrl(path);
    final requestHeaders = _requestHeaders(headers);

    Future<T> getAction() async {
      final res = await _dio.get<dynamic>(
        requestUrl,
        queryParameters: query,
        options: dio.Options(
          headers: requestHeaders,
          contentType: contentType,
        ),
      );

      if (returnRedirectedUri && T is Uri?) {
        return res.realUri as T;
      }

      return res.data != null && decoder != null
          ? decoder.call(res.data)
          : res.data as T;
    }

    return _wrapAction(
      getAction,
      background: background,
      priority: priority,
      hint: 'GET request to $requestUrl',
    );
  }

  /// Method to make a POST request to the API service.
  Future<T> performPost<T>(
    String? path,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    bool returnRedirectedUri = false,
    WorkPriority priority = WorkPriority.high,
    bool background = true,
  }) {
    final requestUrl = _requestUrl(path);
    final requestHeaders = _requestHeaders(headers);

    Future<T> postAction() async {
      final res = await _dio.post<dynamic>(
        requestUrl,
        data: body,
        queryParameters: query,
        options: dio.Options(
          headers: requestHeaders,
          contentType: contentType,
        ),
      );

      if (returnRedirectedUri && T is Uri?) {
        return res.realUri as T;
      }

      return res.data != null && decoder != null
          ? decoder.call(res.data)
          : res.data as T;
    }

    return _wrapAction(
      postAction,
      background: background,
      priority: priority,
      hint: 'POST request to $requestUrl',
    );
  }

  /// Method to make a PUT request to the API service.
  Future<T> performPut<T>(
    String? path,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    WorkPriority priority = WorkPriority.high,
    bool background = true,
  }) {
    final requestUrl = _requestUrl(path);
    final requestHeaders = _requestHeaders(headers);

    Future<T> putAction() async {
      final res = await _dio.put<dynamic>(
        requestUrl,
        data: body,
        queryParameters: query,
        options: dio.Options(
          headers: requestHeaders,
          contentType: contentType,
        ),
      );
      return res.data != null && decoder != null
          ? decoder.call(res.data)
          : res.data as T;
    }

    return _wrapAction(
      putAction,
      background: background,
      priority: priority,
      hint: 'PUT request to $requestUrl',
    );
  }

  /// Method to make a DELETE request to the API service.
  Future<T> performDelete<T>(
    String? path, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    WorkPriority priority = WorkPriority.high,
    bool background = true,
  }) {
    final requestUrl = _requestUrl(path);
    final requestHeaders = _requestHeaders(headers);

    Future<T> deleteAction() async {
      final res = await _dio.delete<dynamic>(
        requestUrl,
        data: body,
        queryParameters: query,
        options: dio.Options(
          headers: requestHeaders,
          contentType: contentType,
        ),
      );
      return res.data != null && decoder != null
          ? decoder.call(res.data)
          : res.data as T;
    }

    return _wrapAction(
      deleteAction,
      background: background,
      priority: priority,
      hint: 'DELETE request to $requestUrl',
    );
  }

  Future<T> _wrapAction<T>(
    Future<T> Function() action, {
    bool background = true,
    WorkPriority priority = WorkPriority.high,
    String? hint,
  }) async {
    StackTrace? mainIsolateStackTrace;
    try {
      if (!background) {
        log.verbose('[$runtimeType] Performing: $hint');
        final res = await action();
        log.verbose('[$runtimeType] Performed successfully: $hint');
        return res;
      }
      if (kDebugMode) {
        mainIsolateStackTrace = StackTrace.current;
      }
      log.verbose('[$runtimeType] Performing backround: $hint');
      final res = await workerManager.execute(
        action,
        priority: priority,
      );
      log.verbose('[$runtimeType] Performed backround successfully: $hint');
      return res;
    } catch (e, s) {
      log.error(
        '[$runtimeType] Perform error: $hint: $e',
        error: e,
        stackTrace: s,
      );
      mainIsolateStackTrace?.printError();
      rethrow;
    }
  }

  String _requestUrl(String? path) => '$baseUrl${path ?? ''}';
  Map<String, String> _requestHeaders(Map<String, String>? headers) => {
        ...this.headers,
        ...?headers,
      };
}

// /// An abstract class representing a base API service.
// ///
// /// This class provides the base URL and headers for an API service.
// abstract class BaseApiService extends GetConnect {
//   /// The base URL for the API service.
//   @override
//   String get baseUrl;

//   /// The headers for the API service.
//   Map<String, String> get headers;

//   /// Method to make a GET request to the API service.
//   @override
//   Future<Response<T>> get<T>(
//     String path, {
//     Map<String, String>? headers,
//     String? contentType,
//     Map<String, dynamic>? query,
//     Decoder<T>? decoder,
//   }) {
//     return super.get<T>(
//       path,
//       headers: headers ?? this.headers,
//       contentType: contentType,
//       query: query,
//       decoder: decoder,
//     );
//   }

//   /// Method to make a POST request to the API service.
//   @override
//   Future<Response<T>> post<T>(
//     String? path,
//     dynamic body, {
//     String? contentType,
//     Map<String, String>? headers,
//     Map<String, dynamic>? query,
//     Decoder<T>? decoder,
//     Progress? uploadProgress,
//   }) {
//     return super.post<T>(
//       path,
//       body,
//       headers: headers ?? this.headers,
//       contentType: contentType,
//       query: query,
//       decoder: decoder,
//       uploadProgress: uploadProgress,
//     );
//   }

//   /// Method to make a PUT request to the API service.
//   @override
//   Future<Response<T>> put<T>(
//     String path,
//     dynamic body, {
//     String? contentType,
//     Map<String, String>? headers,
//     Map<String, dynamic>? query,
//     Decoder<T>? decoder,
//     Progress? uploadProgress,
//   }) {
//     return super.put<T>(
//       path,
//       body,
//       headers: headers ?? this.headers,
//       contentType: contentType,
//       query: query,
//       decoder: decoder,
//       uploadProgress: uploadProgress,
//     );
//   }

//   /// Method to make a DELETE request to the API service.
//   @override
//   Future<Response<T>> delete<T>(
//     String path, {
//     Map<String, String>? headers,
//     String? contentType,
//     Map<String, dynamic>? query,
//     Decoder<T>? decoder,
//   }) {
//     return super.delete<T>(
//       path,
//       headers: headers ?? this.headers,
//       contentType: contentType,
//       query: query,
//       decoder: decoder,
//     );
//   }
// }
