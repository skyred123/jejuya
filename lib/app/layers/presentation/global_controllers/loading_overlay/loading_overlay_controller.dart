import 'dart:async';

import 'package:jejuya/app/common/utils/minimum_loading_time.dart';
import 'package:jejuya/app/core_impl/exception/common_error.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the global Loading overlay state
class LoadingOverlayController extends BaseController with UseCaseProvider {
  /// Default constructor for the LoadingOverlayController.
  LoadingOverlayController();

  // --- State Variables ---

  /// Indicate whether showing loading overlay
  final loading = listenable<bool?>(null);

  // --- Methods ---

  /// Wrap future function with a loading overlay
  Future<T> run<T>(
    Future<T> Function() func, {
    Duration? timeout,
    Duration? minimumLoadingTime = const Duration(milliseconds: 1500),
  }) async {
    loading.value = true;
    final startTime = DateTime.now();
    try {
      final result = timeout == null
          ? await func()
          : await func()
              .timeout(timeout, onTimeout: () => throw CommonError.timeout);
      await MinLoadTime.ensureMinimumLoadingTime(
        startTime,
        minimumLoadingTime,
      );
      return result;
    } catch (_) {
      await MinLoadTime.ensureMinimumLoadingTime(
        startTime,
        minimumLoadingTime,
      );
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
