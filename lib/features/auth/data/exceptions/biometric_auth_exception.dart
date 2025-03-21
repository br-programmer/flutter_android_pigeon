/// A custom exception class for handling biometric authentication errors.
///
/// This exception is thrown when there is an issue related to biometric
/// authentication. It includes a `code` property that provides more
/// information about the error.
///
/// - `code`: A string representing the specific error code associated
///   with the biometric authentication failure.
///
/// The `toString` method is overridden to provide a string representation
/// of the exception, which includes the error code.
class BiometricAuthException implements Exception {
  const BiometricAuthException(this.code);

  final String code;

  @override
  String toString() => 'BiometricAuthException(code: $code)';
}
