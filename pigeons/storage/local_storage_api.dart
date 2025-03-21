import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/storage/local_storage_api.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/dev/brprogrammer/qr/biometrics/app/storage/ILocalStorageApi.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.brprogrammer.qr.biometrics.app.storage',
    ),
    dartPackageName: 'qr.biometrics.app',
  ),
)
@HostApi()
abstract class ILocalStorageApi {
  void save(String value);

  List<String> scans();

  void clear();
}
