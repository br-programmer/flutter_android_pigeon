import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/storage/local_storage_api.g.dart';

class MockLocalStorageApi extends Mock implements ILocalStorageApi {}

void main() {
  group('LocalStorageDatasource', () {
    late MockLocalStorageApi mockApi;
    late LocalStorageDatasource datasource;

    setUp(() {
      mockApi = MockLocalStorageApi();
      datasource = LocalStorageDatasource(api: mockApi);
    });

    test('scans() returns list of scans', () async {
      const scansList = ['scan1', 'scan2'];

      when(() => mockApi.scans()).thenAnswer((_) async => scansList);

      final result = await datasource.scans();

      expect(result, scansList);
      verify(() => mockApi.scans()).called(1);
    });

    test('save() calls api.save', () async {
      const value = 'new_scan';

      when(() => mockApi.save(value)).thenAnswer((_) async {});

      await datasource.save(value);

      verify(() => mockApi.save(value)).called(1);
    });

    test('clear() calls api.clear', () async {
      when(() => mockApi.clear()).thenAnswer((_) async {});

      await datasource.clear();

      verify(() => mockApi.clear()).called(1);
    });
  });
}
