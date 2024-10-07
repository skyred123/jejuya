import 'package:jejuya/core/logger/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// A logger implementation that logs messages using the `logger` package and
/// sends them to Sentry (if enabled).
class Logger implements AppLogger {
  late final _logger = TalkerFlutter.init()
    ..configure(
      filter: const LogLevelFilter(
        level: kDebugMode ? LogLevel.verbose : LogLevel.error,
      ),
      settings: TalkerSettings(
        colors: {
          TalkerLogType.critical: AnsiPen()..red(),
          TalkerLogType.warning: AnsiPen()..yellow(),
          TalkerLogType.verbose: AnsiPen()..magenta(),
          TalkerLogType.info: AnsiPen()..blue(),
          TalkerLogType.debug: AnsiPen()..green(),
          TalkerLogType.error: AnsiPen()..red(),
          TalkerLogType.exception: AnsiPen()..red(),
        },
        titles: {
          TalkerLogType.critical: 'CRITICAL',
          TalkerLogType.warning: 'WARNING',
          TalkerLogType.verbose: 'VERBOSE',
          TalkerLogType.info: 'INFO',
          TalkerLogType.debug: 'DEBUG',
          TalkerLogType.error: 'ERROR',
          TalkerLogType.exception: 'EXCEPTION',
        },
      ),
    );

  /// Logs a verbose message with an optional flag to send it to Sentry.
  @override
  void verbose(String message, {bool sendToCrashlytics = false}) {
    _logger.verbose(message);
    if (sendToCrashlytics) {}
  }

  /// Logs a debug message with an optional flag to send it to Sentry.
  @override
  void debug(String message, {bool sendToCrashlytics = false}) {
    _logger.debug(message);
    if (sendToCrashlytics) {}
  }

  /// Logs an error message with an optional error and stack trace, and an
  /// optional flag to send it to Sentry.
  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    bool sendToCrashlytics = false,
  }) {
    _logger.error(message, error, stackTrace);
    if (sendToCrashlytics) {}
  }

  /// Logs an info message with an optional flag to send it to Sentry.
  @override
  void info(String message, {bool sendToCrashlytics = false}) {
    _logger.info(message);
    if (sendToCrashlytics) {}
  }

  /// Logs a warning message with an optional flag to send it to Sentry.
  @override
  void warning(String message, {bool sendToCrashlytics = false}) {
    _logger.warning(message);
    if (sendToCrashlytics) {}
  }

  /// Logs an critical message with an optional flag to send it to Sentry.
  @override
  void critical(
    String message, {
    Object? exception,
    StackTrace? stackTrace,
    bool sendToCrashlytics = true,
  }) {
    _logger.critical(message, exception, stackTrace);
    if (sendToCrashlytics) {}
  }
}

/// A filter that filters log messages based on their log level.
class LogLevelFilter implements TalkerFilter {
  /// Creates a new log level filter.
  const LogLevelFilter({required this.level});

  /// The log level to filter by.
  final LogLevel level;

  @override
  bool filter(TalkerData item) {
    return logLevelPriorityList.indexOf(item.logLevel ?? LogLevel.verbose) <=
        logLevelPriorityList.indexOf(level);
  }
}
