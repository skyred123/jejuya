/// A utility class for ensuring a minimum loading time.
class MinLoadTime {
  /// Ensure a minimum loading time.
  static Future<void> ensureMinimumLoadingTime(
    DateTime startTime, [
    Duration? minDuration = const Duration(milliseconds: 1500),
  ]) async {
    if (minDuration == null || minDuration == Duration.zero) return;
    final elapsedTime = DateTime.now().difference(startTime);
    if (elapsedTime <= Duration.zero || elapsedTime > minDuration) return;
    await Future<void>.delayed(
      minDuration - elapsedTime,
    );
  }
}
