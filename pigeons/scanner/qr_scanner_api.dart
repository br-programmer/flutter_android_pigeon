import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/scanner/qr_scanner_api.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/dev/brprogrammer/qr/biometrics/app/scanner/IQrScannerApi.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.brprogrammer.qr.biometrics.app.scanner',
    ),
    dartPackageName: 'qr.biometrics.app',
  ),
)
@HostApi()
abstract class IQrScannerApi {
  @async
  String scan();
}
