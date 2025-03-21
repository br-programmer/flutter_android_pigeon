import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

class MockScannerDatasource extends Mock implements IScannerDatasource {}

void main() {
  late MockScannerDatasource mockDatasource;
  late IScannerRepository repository;

  setUp(() {
    mockDatasource = MockScannerDatasource();
    repository = ScannerRepository(datasource: mockDatasource);
  });

  group('ScannerRepository', () {
    test('returns Success when datasource succeeds', () async {
      const scanResult = 'scanned_qr_value';
      when(() => mockDatasource.scan()).thenAnswer((_) async => scanResult);

      final result = await repository.scan();

      expect(result, isA<Success<String, ScannerFailure>>());
      expect((result as Success).data, scanResult);
      verify(() => mockDatasource.scan()).called(1);
    });

    test('returns PlatformScannerFailure when PlatformException thrown',
        () async {
      when(() => mockDatasource.scan())
          .thenThrow(PlatformException(code: 'error'));

      final result = await repository.scan();

      expect(result, isA<Failure<String, ScannerFailure>>());
      expect((result as Failure).error, isA<PlatformScannerFailure>());
      verify(() => mockDatasource.scan()).called(1);
    });

    test('returns UnknownScannerFailure when Exception thrown', () async {
      final exception = Exception('unexpected error');
      when(() => mockDatasource.scan()).thenThrow(exception);

      final result = await repository.scan();

      expect(result, isA<Failure<String, ScannerFailure>>());
      expect((result as Failure).error, isA<UnknownScannerFailure>());
      verify(() => mockDatasource.scan()).called(1);
    });
  });
}
