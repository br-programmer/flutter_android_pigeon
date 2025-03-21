import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/features/features.dart';

void main() {
  group('AuthFailure.fromCode', () {
    test('returns BiometricUnavailable on code "unavailable"', () {
      final result = AuthFailure.fromCode('unavailable');
      expect(result, isA<BiometricUnavailable>());
      expect(result.code, 'unavailable');
      expect(result.cancelled, false);
    });

    test('returns AuthenticationFailed on code "failed"', () {
      final result = AuthFailure.fromCode('failed');
      expect(result, isA<AuthenticationFailed>());
      expect(result.code, 'failed');
      expect(result.cancelled, false);
    });

    test('returns AuthenticationError on code "error"', () {
      final result = AuthFailure.fromCode('error');
      expect(result, isA<AuthenticationError>());
      expect(result.code, 'error');
      expect(result.cancelled, false);
    });

    test('returns AuthenticationCancelled on code "cancelled"', () {
      final result = AuthFailure.fromCode('cancelled');
      expect(result, isA<AuthenticationCancelled>());
      expect(result.code, 'cancelled');
      expect(result.cancelled, true);
    });

    test('returns UnknownAuthFailure on unknown code', () {
      final result = AuthFailure.fromCode('some_unknown_code');
      expect(result, isA<UnknownAuthFailure>());
      expect(result.code, 'some_unknown_code');
      expect((result as UnknownAuthFailure).error, 'some_unknown_code');
      expect(result.cancelled, false);
    });

    test('PlatformAuthFailure and UnknownAuthFailure coverage', () {
      const platform = PlatformAuthFailure(error: 'platform error');
      const unknown = UnknownAuthFailure(error: 'unknown error');

      expect(platform.error, 'platform error');
      expect(platform.code, 'platform_error');
      expect(platform.cancelled, false);

      expect(unknown.error, 'unknown error');
      expect(unknown.code, 'unknown error');
      expect(unknown.cancelled, false);
    });
  });
}
