import 'dart:async';

import 'package:jejuya/core/di/initializable.dart';
import 'package:get_it/get_it.dart';

/// This abstract class serves as the base controller for all controllers in
/// the application.
///
/// All controllers should extend this class to ensure consistency in the
/// codebase.
///
/// The [BaseController] class provides a template for implementing the
/// controller pattern in the application. It defines a set of methods that
/// should be implemented by all controllers, such as onDispose.
///
/// By extending this class, controllers can inherit these methods and
/// implement their own custom logic on top of them. This helps to ensure
/// consistency in the codebase and makes it easier to maintain and update the
/// application over time.
abstract class BaseController with Disposable, Initializable {
  /// Initialize the controller
  @override
  Future<void> initialize() async {}
}
