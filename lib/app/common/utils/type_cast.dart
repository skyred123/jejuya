/// Extension method to cast an object to a specific type.
extension ObjectCast on Object {
  /// Casts the object to the specified type.
  ///
  /// Returns the object casted to the specified type,
  /// otherwise returns null.
  T? cast<T>() {
    if (this is T) return this as T;
    return null;
  }
}
