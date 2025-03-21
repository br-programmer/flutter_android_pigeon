import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/features/features.dart';

void main() {
  group('ScannerFailure', () {
    test('PlatformScannerFailure has no properties', () {
      const failure = PlatformScannerFailure();
      expect(failure, isA<ScannerFailure>());
    });

    test('UnknownScannerFailure retains error object', () {
      const error = 'unexpected';
      const failure = UnknownScannerFailure(error: error);

      expect(failure, isA<ScannerFailure>());
      expect(failure.error, error);
    });
  });
}
