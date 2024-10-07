import 'package:jejuya/core/analytic/analytic_action.dart';
import 'package:jejuya/core/analytic/analytic_action_performer.dart';

/// An abstract class representing an analytic service.
///
/// This class defines the contract for performing analytic actions and adding
/// action performers.
///
/// The type parameter `A` represents the type of analytic action that can be
/// performed.
abstract class AnalyticService<A extends AnalyticAction> {
  /// Performs the given [action].
  void performAction(A action);

  /// Adds an [AnalyticActionPerformer] to the service.
  ///
  /// Returns `true` if the performer was successfully added, `false` otherwise.
  bool addActionPerformer(AnalyticActionPerformer<AnalyticAction> performer);
}
