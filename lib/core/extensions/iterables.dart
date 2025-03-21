import 'dart:core';

/// Extension on [Iterable] providing utility methods for transformation.
extension IterableX<E> on Iterable<E> {
  /// Maps each element of the iterable using the provided function [f]
  /// and returns the results as a [List].
  ///
  /// This is a shorthand for `iterable.map(f).toList()`, improving readability
  /// and reducing boilerplate when a list result is needed directly.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3];
  /// final squares = numbers.mapList((n) => n * n); // [1, 4, 9]
  /// ```
  List<T> mapList<T>(T Function(E element) f) {
    return map(f).toList();
  }
}
