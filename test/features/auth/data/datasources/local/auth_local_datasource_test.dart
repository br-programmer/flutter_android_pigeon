import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/biometric/biometrics_api.g.dart';

class MockBiometricsApi extends Mock implements IBiometricsApi {}

class FakeBiometricTexts extends Fake implements BiometricTexts {}

class FakeBiometricMethodDto extends Fake implements BiometricMethodDto {}

void main() {
  late MockBiometricsApi api;
  late AuthLocalDatasource datasource;

  setUp(() {
    api = MockBiometricsApi();
    datasource = AuthLocalDatasource(api: api);
    registerFallbackValue(FakeBiometricTexts());
    registerFallbackValue(FakeBiometricMethodDto());
  });

  test('getAvailableMethods returns mapped AuthMethods', () async {
    when(() => api.methodsAvailable()).thenAnswer(
      (_) async => [
        BiometricMethodDto(method: 'biometric_strong'),
        BiometricMethodDto(method: 'biometric_weak'),
        BiometricMethodDto(method: 'device_credential'),
        BiometricMethodDto(method: 'unknown'),
      ],
    );

    final methods = await datasource.getAvailableMethods();

    expect(methods, [
      AuthMethod.biometricStrong,
      AuthMethod.biometricWeak,
      AuthMethod.deviceCredential,
      AuthMethod.unsupported,
    ]);
  });

  test('canAuthenticate delegates to api', () async {
    when(() => api.canAuthenticate(any())).thenAnswer((_) async => true);

    final result = await datasource.canAuthenticate(AuthMethod.biometricStrong);

    expect(result, isTrue);

    verify(() => api.canAuthenticate(any())).called(1);
  });

  group('authenticate', () {
    const title = 'Title';
    const subtitle = 'Subtitle';
    const cancel = 'Cancel';
    const method = AuthMethod.biometricStrong;

    test('throws BiometricAuthException when result has message', () async {
      when(() => api.authenticate(any(), any())).thenAnswer(
        (_) async => BiometricResultDto(code: 'failed', message: 'Some error'),
      );

      expect(
        () => datasource.authenticate(
          method: method,
          title: title,
          subtitle: subtitle,
          cancel: cancel,
        ),
        throwsA(isA<BiometricAuthException>()),
      );
    });

    test('returns void when authentication succeeds', () async {
      when(() => api.authenticate(any(), any())).thenAnswer(
        (_) async => BiometricResultDto(code: 'success'),
      );

      expect(
        () => datasource.authenticate(
          method: method,
          title: title,
          subtitle: subtitle,
          cancel: cancel,
        ),
        returnsNormally,
      );
    });
  });
}
