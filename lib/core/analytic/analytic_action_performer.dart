import 'package:jejuya/core/analytic/analytic_action.dart';

/// An abstract class representing an analytic action performer.
///
/// This class defines the basic structure for performing analytic actions.
/// It provides a method to check if a given [AnalyticAction] can be handled
/// by the performer, and a method to perform the action.
///
/// Subclasses of [AnalyticActionPerformer] should implement the [canHandle]
/// method to specify the type of [AnalyticAction] they can handle, and the
/// [perform] method to define the action to be performed.
abstract class AnalyticActionPerformer<A extends AnalyticAction> {
  /// Default constructor for [AnalyticActionPerformer].
  const AnalyticActionPerformer();

  /// Checks if the performer can handle the given [action].
  bool canHandle(AnalyticAction action) => action is A;

  /// Performs the given [action].
  void perform(A action);
}
