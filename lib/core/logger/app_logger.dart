/// An interface for logging messages in the application.
abstract interface class AppLogger {
  /// Logs an informational message.
  ///
  /// [message] - The message to log.
  void info(String message) {}

  /// Logs a verbose message.
  ///
  /// [message] - The message to log.
  ///
  /// [sendToCrashlytics] - Whether to send the message to Crashlytics.
  void verbose(String message, {bool sendToCrashlytics = false}) {}

  /// Logs a debug message.
  ///
  /// [message] - The message to log.
  ///
  /// [sendToCrashlytics] - Whether to send the message to Crashlytics.
  void debug(String message, {bool sendToCrashlytics = false}) {}

  /// Logs a warning message.
  ///
  /// [message] - The message to log.
  ///
  /// [sendToCrashlytics] - Whether to send the message to Crashlytics.
  void warning(String message, {bool sendToCrashlytics = false}) {}

  /// Logs an error message.
  ///
  /// [message] - The message to log.
  ///
  /// [error] - The error object associated with the message.
  ///
  /// [stackTrace] - The stack trace associated with the error.
  ///
  /// [sendToCrashlytics] - Whether to send the message to Crashlytics.
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    bool sendToCrashlytics = false,
  }) {}

  /// Logs an critical message.
  ///
  /// [message] - The message to log.
  ///
  /// [exception] - The exception object associated with the message.
  ///
  /// [stackTrace] - The stack trace associated
  ///
  /// [sendToCrashlytics] - Whether to send the message to Crashlytics.
  void critical(
    String message, {
    Object? exception,
    StackTrace? stackTrace,
    bool sendToCrashlytics = true,
  }) {}
}
