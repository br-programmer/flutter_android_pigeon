import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

class MockAuthDatasource extends Mock implements IAuthDatasource {}

void main() {
  late MockAuthDatasource dataSource;
  late IAuthRepository repository;

  setUp(() {
    dataSource = MockAuthDatasource();
    repository = AuthRepository(dataSource: dataSource);
  });

  group('getAvailableMethods', () {
    test('returns Success when datasource succeeds', () async {
      when(() => dataSource.getAvailableMethods())
          .thenAnswer((_) async => [AuthMethod.biometricStrong]);

      final result = await repository.getAvailableMethods();

      expect(result, isA<Success<List<AuthMethod>, AuthFailure>>());
      expect((result as Success).data, [AuthMethod.biometricStrong]);
    });

    test('returns PlatformAuthFailure on PlatformException', () async {
      when(() => dataSource.getAvailableMethods())
          .thenThrow(PlatformException(code: 'error'));

      final result = await repository.getAvailableMethods();

      expect(result, isA<Failure<List<AuthMethod>, AuthFailure>>());
      expect((result as Failure).error, isA<PlatformAuthFailure>());
    });

    test('returns UnknownAuthFailure on generic Exception', () async {
      when(() => dataSource.getAvailableMethods()).thenThrow(Exception('fail'));

      final result = await repository.getAvailableMethods();

      expect(result, isA<Failure<List<AuthMethod>, AuthFailure>>());
      expect((result as Failure).error, isA<UnknownAuthFailure>());
    });
  });

  group('canAuthenticate', () {
    test('returns Success when datasource succeeds', () async {
      when(() => dataSource.canAuthenticate(AuthMethod.biometricStrong))
          .thenAnswer((_) async => true);

      final result = await repository.canAuthenticate(
        AuthMethod.biometricStrong,
      );

      expect(result, isA<Success<bool, AuthFailure>>());
      expect((result as Success).data, true);
    });

    test('returns PlatformAuthFailure on PlatformException', () async {
      when(() => dataSource.canAuthenticate(AuthMethod.biometricStrong))
          .thenThrow(PlatformException(code: 'error'));

      final result = await repository.canAuthenticate(
        AuthMethod.biometricStrong,
      );

      expect(result, isA<Failure<bool, AuthFailure>>());
      expect((result as Failure).error, isA<PlatformAuthFailure>());
    });

    test('returns UnknownAuthFailure on generic Exception', () async {
      when(() => dataSource.canAuthenticate(AuthMethod.biometricStrong))
          .thenThrow(Exception('fail'));

      final result = await repository.canAuthenticate(
        AuthMethod.biometricStrong,
      );

      expect(result, isA<Failure<bool, AuthFailure>>());
      expect((result as Failure).error, isA<UnknownAuthFailure>());
    });
  });

  group('authenticate', () {
    test('returns Success when datasource succeeds', () async {
      when(
        () => dataSource.authenticate(
          method: AuthMethod.biometricStrong,
          title: any(named: 'title'),
          subtitle: any(named: 'subtitle'),
          cancel: any(named: 'cancel'),
        ),
      ).thenAnswer((_) async {});

      final result = await repository.authenticate(
        method: AuthMethod.biometricStrong,
        title: 'Title',
        subtitle: 'Subtitle',
        cancel: 'Cancel',
      );

      expect(result, isA<Success<void, AuthFailure>>());
      expect((result as Success).data, isNull);
    });

    test('returns mapped AuthFailure from BiometricAuthException', () async {
      when(
        () => dataSource.authenticate(
          method: AuthMethod.biometricStrong,
          title: any(named: 'title'),
          subtitle: any(named: 'subtitle'),
          cancel: any(named: 'cancel'),
        ),
      ).thenThrow(const BiometricAuthException('failed'));

      final result = await repository.authenticate(
        method: AuthMethod.biometricStrong,
        title: 'Title',
        subtitle: 'Subtitle',
        cancel: 'Cancel',
      );

      expect(result, isA<Failure<void, AuthFailure>>());
      expect((result as Failure).error, isA<AuthenticationFailed>());
    });

    test('returns PlatformAuthFailure on PlatformException', () async {
      when(
        () => dataSource.authenticate(
          method: AuthMethod.biometricStrong,
          title: any(named: 'title'),
          subtitle: any(named: 'subtitle'),
          cancel: any(named: 'cancel'),
        ),
      ).thenThrow(PlatformException(code: 'error'));

      final result = await repository.authenticate(
        method: AuthMethod.biometricStrong,
        title: 'Title',
        subtitle: 'Subtitle',
        cancel: 'Cancel',
      );

      expect(result, isA<Failure<void, AuthFailure>>());
      expect((result as Failure).error, isA<PlatformAuthFailure>());
    });

    test('returns UnknownAuthFailure on generic Exception', () async {
      when(
        () => dataSource.authenticate(
          method: AuthMethod.biometricStrong,
          title: any(named: 'title'),
          subtitle: any(named: 'subtitle'),
          cancel: any(named: 'cancel'),
        ),
      ).thenThrow(Exception('fail'));

      final result = await repository.authenticate(
        method: AuthMethod.biometricStrong,
        title: 'Title',
        subtitle: 'Subtitle',
        cancel: 'Cancel',
      );

      expect(result, isA<Failure<void, AuthFailure>>());
      expect((result as Failure).error, isA<UnknownAuthFailure>());
    });
  });
}
