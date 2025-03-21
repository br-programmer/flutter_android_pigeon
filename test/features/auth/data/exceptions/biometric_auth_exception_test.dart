import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/features/features.dart';

void main() {
  test('BiometricAuthException creates and toString works', () {
    const exception = BiometricAuthException('error_code');

    expect(exception.code, 'error_code');
    expect(exception.toString(), 'BiometricAuthException(code: error_code)');
  });
}
