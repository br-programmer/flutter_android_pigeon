import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/features/features.dart';

void main() {
  group('StorageFailure', () {
    test('StorageWriteFailure has no properties', () {
      const failure = StorageWriteFailure();
      expect(failure, isA<StorageFailure>());
    });

    test('StorageReadFailure has no properties', () {
      const failure = StorageReadFailure();
      expect(failure, isA<StorageFailure>());
    });

    test('UnknownStorageFailure retains error object', () {
      const error = 'unexpected';
      const failure = UnknownStorageFailure(error: error);

      expect(failure, isA<StorageFailure>());
      expect(failure.error, error);
    });
  });
}
