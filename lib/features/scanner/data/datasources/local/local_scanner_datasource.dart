import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/scanner/qr_scanner_api.g.dart';

/// A local implementation of the [IScannerDatasource] interface.
///
/// This class uses the [IQrScannerApi] to perform scanning operations locally.
/// It delegates the scanning task to the API and returns the scan result.
///
/// - [scan]: Initiates a scan by calling the [scan] method from the [IQrScannerApi],
///   which returns the scan result (usually a string representing the scanned data).
class LocalScannerDatasource implements IScannerDatasource {
  LocalScannerDatasource({required IQrScannerApi api}) : _api = api;

  final IQrScannerApi _api;

  /// Initiates a scan operation using the [IQrScannerApi].
  ///
  /// This method calls the `scan` method of the provided [IQrScannerApi] instance
  /// and returns the scanned data as a string. The scan result is typically a QR code
  /// or barcode value.
  @override
  Future<String> scan() => _api.scan();
}
