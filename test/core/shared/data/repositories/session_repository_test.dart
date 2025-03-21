import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/core.dart';

class MockSessionDatasource extends Mock implements ISessionDatasource {}

void main() {
  late MockSessionDatasource datasource;
  late SessionRepository repository;

  setUp(() {
    datasource = MockSessionDatasource();
    repository = SessionRepository(dataSource: datasource);
  });

  group('SessionRepository', () {
    group('saveSession', () {
      test('returns Success when datasource succeeds', () async {
        when(() => datasource.saveSession(true))
            .thenAnswer((_) async => Future.value());

        final result = await repository.saveSession(true);

        expect(result, isA<Success<void, SessionFailure>>());
        expect((result as Success).data, isNull);

        verify(() => datasource.saveSession(true)).called(1);
      });

      test('returns SaveSessionFailure on PlatformException', () async {
        when(() => datasource.saveSession(any()))
            .thenThrow(PlatformException(code: 'save_error'));

        final result = await repository.saveSession(true);

        expect(result, isA<Failure<void, SessionFailure>>());

        expect((result as Failure).error, isA<SaveSessionFailure>());
      });

      test('returns UnknownSessionFailure on Exception', () async {
        when(() => datasource.saveSession(any())).thenThrow(Exception());

        final result = await repository.saveSession(true);

        expect(result, isA<Failure<void, SessionFailure>>());

        expect((result as Failure).error, isA<UnknownSessionFailure>());
      });
    });

    group('sessionActive', () {
      test('returns Success(true) when datasource returns true', () async {
        when(() => datasource.sessionActive()).thenAnswer((_) async => true);

        final result = await repository.sessionActive();

        expect(result, isA<Success<bool, SessionFailure>>());
        expect((result as Success).data, isTrue);
      });

      test('returns Success(false) when datasource returns false', () async {
        when(() => datasource.sessionActive()).thenAnswer((_) async => false);

        final result = await repository.sessionActive();

        expect(result, isA<Success<bool, SessionFailure>>());
        expect((result as Success).data, isFalse);
      });

      test('returns Success(false) when datasource returns null', () async {
        when(() => datasource.sessionActive()).thenAnswer((_) async => null);

        final result = await repository.sessionActive();

        expect(result, isA<Success<bool, SessionFailure>>());
        expect((result as Success).data, isFalse);
      });

      test('returns ReadSessionFailure on PlatformException', () async {
        when(() => datasource.sessionActive())
            .thenThrow(PlatformException(code: 'read_error'));

        final result = await repository.sessionActive();

        expect(result, isA<Failure<bool, SessionFailure>>());

        expect((result as Failure).error, isA<ReadSessionFailure>());
      });

      test('returns UnknownSessionFailure on Exception', () async {
        when(() => datasource.sessionActive()).thenThrow(Exception());

        final result = await repository.sessionActive();

        expect(result, isA<Failure<bool, SessionFailure>>());
        expect((result as Failure).error, isA<UnknownSessionFailure>());
      });
    });

    group('clearSession', () {
      test('returns Success when datasource succeeds', () async {
        when(() => datasource.clearSession())
            .thenAnswer((_) async => Future.value());

        final result = await repository.clearSession();

        expect(result, isA<Success<void, SessionFailure>>());

        expect((result as Success).data, isNull);

        verify(() => datasource.clearSession()).called(1);
      });

      test('returns ClearSessionFailure on PlatformException', () async {
        when(() => datasource.clearSession())
            .thenThrow(PlatformException(code: 'clear_error'));

        final result = await repository.clearSession();

        expect(result, isA<Failure<void, SessionFailure>>());

        expect((result as Failure).error, isA<ClearSessionFailure>());
      });

      test('returns UnknownSessionFailure on Exception', () async {
        when(() => datasource.clearSession()).thenThrow(Exception());

        final result = await repository.clearSession();

        expect(result, isA<Failure<void, SessionFailure>>());

        expect((result as Failure).error, isA<UnknownSessionFailure>());
      });
    });
  });
}
