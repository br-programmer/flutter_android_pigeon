class BiometricAuthException implements Exception {
  const BiometricAuthException(this.code);

  final String code;

  @override
  String toString() => 'BiometricAuthException(code: $code)';
}
