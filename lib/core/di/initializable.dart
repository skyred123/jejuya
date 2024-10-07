/// Interface for classes that need to be initialized
// ignore: one_member_abstracts
abstract mixin class Initializable {
  /// Initialize the class
  Future<void> initialize();
}
