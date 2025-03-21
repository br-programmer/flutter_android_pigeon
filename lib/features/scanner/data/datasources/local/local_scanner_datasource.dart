import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/scanner/qr_scanner_api.g.dart';

class LocalScannerDatasource implements IScannerDatasource {
  LocalScannerDatasource({required IQrScannerApi api}) : _api = api;

  final IQrScannerApi _api;

  @override
  Future<String> scan() => _api.scan();
}
