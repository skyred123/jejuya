import 'package:jejuya/core/exception/base_error.dart';
import 'package:dio/dio.dart';

/// Represents the different types of api errors that can occur.
enum ApiError implements BaseError {
  /// Represents an unknown error.
  /// This occurs when an error is thrown but the type is not recognized.
  unknown(
    'unknown',
    'error.unknown',
  ),

  /// Represents a connection timeout error.
  connectionTimeout(
    'connection_timeout',
    'error.api.connection_timeout',
  ),

  /// Represents a send timeout error.
  sendTimeout(
    'send_timeout',
    'error.api.send_timeout',
  ),

  /// Represents a receive timeout error.
  receiveTimeout(
    'receive_timeout',
    'error.api.receive_timeout',
  ),

  /// Represents a bad certificate error.
  badCertificate(
    'bad_certificate',
    'error.api.bad_certificate',
  ),

  /// Represents a bad response error.
  badResponse(
    'bad_response',
    'error.api.bad_response',
  ),

  /// Represents a request cancelled error.
  cancel(
    'cancel',
    'error.api.cancel',
  ),

  /// Represents a connection error.
  connectionError(
    'connection_error',
    'error.api.connection_error',
  ),
  ;

  /// Creates a new instance of [ApiError].
  const ApiError(this.code, this.message);

  /// The error code.
  @override
  final String code;

  /// The error message.
  @override
  final String message;
}

/// Map [DioException] to [ApiError].
extension ApiErrorExtension on DioException {
  /// Maps [DioException] to [ApiError].
  ApiError toApiError() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return ApiError.connectionTimeout;

      case DioExceptionType.sendTimeout:
        return ApiError.sendTimeout;

      case DioExceptionType.receiveTimeout:
        return ApiError.receiveTimeout;

      case DioExceptionType.badCertificate:
        return ApiError.badCertificate;

      case DioExceptionType.badResponse:
        return ApiError.badResponse;

      case DioExceptionType.cancel:
        return ApiError.cancel;

      case DioExceptionType.connectionError:
        return ApiError.connectionError;

      case DioExceptionType.unknown:
        return ApiError.unknown;
    }
  }
}
