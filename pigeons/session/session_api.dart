import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/session/session_api.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/dev/brprogrammer/qr/biometrics/app/session/ISessionApi.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.brprogrammer.qr.biometrics.app.session',
    ),
    dartPackageName: 'qr.biometrics.app',
  ),
)
@HostApi()
abstract class ISessionApi {
  void saveSession(bool authenticated);

  bool? getSession();

  void clearSession();
}
