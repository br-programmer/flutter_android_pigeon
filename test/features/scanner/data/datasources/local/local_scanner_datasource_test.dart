import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/scanner/qr_scanner_api.g.dart';

class MockQrScannerApi extends Mock implements IQrScannerApi {}

void main() {
  group('LocalScannerDatasource', () {
    late MockQrScannerApi mockApi;
    late LocalScannerDatasource datasource;

    setUp(() {
      mockApi = MockQrScannerApi();
      datasource = LocalScannerDatasource(api: mockApi);
    });

    test('scan() returns scanned value', () async {
      const scannedValue = 'wifi_password';

      when(() => mockApi.scan()).thenAnswer((_) async => scannedValue);

      final result = await datasource.scan();

      expect(result, scannedValue);
      verify(() => mockApi.scan()).called(1);
    });
  });
}
