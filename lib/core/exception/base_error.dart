/// This file defines the [BaseError] interface, which is the base class for all
/// errors in the application.
///
/// All errors in the application should implement this interface to ensure
/// consistency in error handling.
abstract interface class BaseError implements Exception {
  /// A code that represents the error.
  ///
  /// This code can be used to identify the error in logs or when reporting the
  /// error to external systems.
  String get code;

  /// A message that describes the error.
  ///
  /// This message should provide a clear and concise description of the error
  /// that occurred.
  String get message;
}
