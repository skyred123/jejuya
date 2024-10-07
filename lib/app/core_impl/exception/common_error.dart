import 'package:jejuya/core/exception/base_error.dart';

/// Represents the different types of common errors that can occur.
enum CommonError implements BaseError {
  /// Represents an unknown error.
  /// This occurs when an error is thrown but the type is not recognized.
  unknown(
    'unknown',
    'error.unknown',
  ),

  /// Represents missing context error.
  missingContext(
    'missing_context',
    'error.common.missing_context',
  ),

  /// Represents parsing type error
  invalidType(
    'invalid_type',
    'error.common.invalid_type',
  ),

  /// Represents missing data error.
  missingData(
    'missing_data',
    'error.common.missing_data',
  ),

  /// Represents timeout error.
  timeout(
    'timeout',
    'error.common.timeout',
  ),

  /// Represents unsupported error.
  unsupported(
    'unsupported',
    'error.common.unsupported',
  );

  /// Creates a new instance of [CommonError].
  const CommonError(this.code, this.message);

  /// The error code.
  @override
  final String code;

  /// The error message.
  @override
  final String message;
}
