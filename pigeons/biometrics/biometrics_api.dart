import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/biometric/biometrics_api.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/dev/brprogrammer/qr/biometrics/app/biometric/IBiometricsApi.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.brprogrammer.qr.biometrics.app.biometric',
    ),
    dartPackageName: 'qr.biometrics.app',
  ),
)
class BiometricTexts {
  BiometricTexts({
    required this.title,
    required this.subtitle,
    required this.cancel,
  });

  final String title;
  final String subtitle;
  final String? cancel;
}

class BiometricMethodDto {
  BiometricMethodDto({required this.method});

  final String method;
}

class BiometricResultDto {
  BiometricResultDto({
    required this.code,
    required this.message,
  });

  final String code;
  final String? message;
}

@HostApi()
abstract class IBiometricsApi {
  @async
  List<BiometricMethodDto> methodsAvailable();

  @async
  bool canAuthenticate(BiometricMethodDto method);

  @async
  BiometricResultDto authenticate(
    BiometricTexts texts,
    BiometricMethodDto method,
  );
}
