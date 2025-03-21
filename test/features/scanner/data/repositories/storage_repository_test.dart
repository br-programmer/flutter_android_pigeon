import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

class MockStorageDatasource extends Mock implements IStorageDatasource {}

void main() {
  late MockStorageDatasource mockDatasource;
  late IStorageRepository repository;

  setUp(() {
    mockDatasource = MockStorageDatasource();
    repository = StorageRepository(datasource: mockDatasource);
  });

  group('StorageRepository', () {
    test('save returns Success when datasource succeeds', () async {
      const value = 'qr_value';
      when(() => mockDatasource.save(value)).thenAnswer((_) async {});

      final result = await repository.save(value);

      expect(result, isA<Success<void, StorageFailure>>());
      expect((result as Success).data, isNull);
      verify(() => mockDatasource.save(value)).called(1);
    });

    test('save returns StorageWriteFailure on PlatformException', () async {
      const value = 'qr_value';
      when(() => mockDatasource.save(value))
          .thenThrow(PlatformException(code: 'error'));

      final result = await repository.save(value);

      expect(result, isA<Failure<void, StorageFailure>>());
      expect((result as Failure).error, isA<StorageWriteFailure>());
      verify(() => mockDatasource.save(value)).called(1);
    });

    test('save returns UnknownStorageFailure on Exception', () async {
      const value = 'qr_value';
      final exception = Exception('save failed');
      when(() => mockDatasource.save(value)).thenThrow(exception);

      final result = await repository.save(value);

      expect(result, isA<Failure<void, StorageFailure>>());
      expect((result as Failure).error, isA<UnknownStorageFailure>());
      verify(() => mockDatasource.save(value)).called(1);
    });

    test('scans returns Success with data when datasource succeeds', () async {
      const scanList = ['qr1', 'qr2'];
      when(() => mockDatasource.scans()).thenAnswer((_) async => scanList);

      final result = await repository.scans();

      expect(result, isA<Success<List<String>, StorageFailure>>());
      expect((result as Success).data, scanList);
      verify(() => mockDatasource.scans()).called(1);
    });

    test('scans returns StorageReadFailure on PlatformException', () async {
      when(() => mockDatasource.scans())
          .thenThrow(PlatformException(code: 'error'));

      final result = await repository.scans();

      expect(result, isA<Failure<List<String>, StorageFailure>>());
      expect((result as Failure).error, isA<StorageReadFailure>());
      verify(() => mockDatasource.scans()).called(1);
    });

    test('scans returns UnknownStorageFailure on Exception', () async {
      final exception = Exception('read failed');
      when(() => mockDatasource.scans()).thenThrow(exception);

      final result = await repository.scans();

      expect(result, isA<Failure<List<String>, StorageFailure>>());
      expect((result as Failure).error, isA<UnknownStorageFailure>());
      verify(() => mockDatasource.scans()).called(1);
    });

    test('clear returns Success when datasource succeeds', () async {
      when(() => mockDatasource.clear()).thenAnswer((_) async {});

      final result = await repository.clear();

      expect(result, isA<Success<void, StorageFailure>>());
      expect((result as Success).data, isNull);
      verify(() => mockDatasource.clear()).called(1);
    });

    test('clear returns StorageWriteFailure on PlatformException', () async {
      when(() => mockDatasource.clear())
          .thenThrow(PlatformException(code: 'error'));

      final result = await repository.clear();

      expect(result, isA<Failure<void, StorageFailure>>());
      expect((result as Failure).error, isA<StorageWriteFailure>());
      verify(() => mockDatasource.clear()).called(1);
    });

    test('clear returns UnknownStorageFailure on Exception', () async {
      final exception = Exception('clear failed');
      when(() => mockDatasource.clear()).thenThrow(exception);

      final result = await repository.clear();

      expect(result, isA<Failure<void, StorageFailure>>());
      expect((result as Failure).error, isA<UnknownStorageFailure>());
      verify(() => mockDatasource.clear()).called(1);
    });
  });
}
