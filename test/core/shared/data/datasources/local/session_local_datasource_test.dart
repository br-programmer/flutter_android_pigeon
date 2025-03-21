import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/pigeon/session/session_api.g.dart';

class MockSessionApi extends Mock implements ISessionApi {}

void main() {
  late MockSessionApi mockApi;
  late SessionLocalDatasource datasource;

  setUp(() {
    mockApi = MockSessionApi();
    datasource = SessionLocalDatasource(api: mockApi);
  });

  group('SessionLocalDatasource', () {
    test('saveSession calls SessionApi.saveSession with true', () async {
      when(() => mockApi.saveSession(true))
          .thenAnswer((_) async => Future.value());

      await datasource.saveSession(true);

      verify(() => mockApi.saveSession(true)).called(1);
    });

    test('saveSession calls SessionApi.saveSession with false', () async {
      when(() => mockApi.saveSession(false))
          .thenAnswer((_) async => Future.value());

      await datasource.saveSession(false);

      verify(() => mockApi.saveSession(false)).called(1);
    });

    test('sessionActive returns true when SessionApi returns true', () async {
      when(() => mockApi.getSession()).thenAnswer((_) async => true);

      final result = await datasource.sessionActive();

      expect(result, isTrue);
      verify(() => mockApi.getSession()).called(1);
    });

    test('sessionActive returns false when SessionApi returns false', () async {
      when(() => mockApi.getSession()).thenAnswer((_) async => false);

      final result = await datasource.sessionActive();

      expect(result, isFalse);
      verify(() => mockApi.getSession()).called(1);
    });

    test('sessionActive returns null when SessionApi returns null', () async {
      when(() => mockApi.getSession()).thenAnswer((_) async => null);

      final result = await datasource.sessionActive();

      expect(result, isNull);
      verify(() => mockApi.getSession()).called(1);
    });

    test('clearSession calls SessionApi.clearSession', () async {
      when(() => mockApi.clearSession())
          .thenAnswer((_) async => Future.value());

      await datasource.clearSession();

      verify(() => mockApi.clearSession()).called(1);
    });
  });
}
