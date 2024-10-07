/// The base use case class that defines the contract for executing a use case.
///
/// A use case represents a specific task or operation in the application.
/// It takes a request object as input and returns a response object as output.
/// Implementations of this class should provide the logic to run the use case.
// ignore: one_member_abstracts
abstract class BaseUseCase<Request, Response> {
  /// Executes the use case with the given [request] object.
  ///
  /// Returns a [Future] that completes with the [Response] object.
  Future<Response> execute(Request request);

  // /// Executes the use case with the given [request] object.
  // ///
  // /// Returns a [Stream] that emits the [Response] object.
  // Stream<Response> executeStream(Request request) async* {
  //   yield await execute(request);
  // }

  // /// Executes the use case with the given [request] object.
  // ///
  // /// Returns the [Response] object.
  // Response executeSync(Request request) {
  //   throw UnimplementedError();
  // }
}
