import 'package:flutter/services.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// A concrete implementation of the [IScannerRepository] interface.
///
/// This class handles the scanning operations by interacting with a datasource
/// that performs the actual scanning. It provides a method to initiate a scan
/// and handles any errors using [ScannerFailure]. The result is wrapped in a
/// [FutureResult] to indicate whether the scan was successful or failed.
///
/// The [scan] method is responsible for calling the underlying datasource's
/// [scan] method and returning the result.
class ScannerRepository implements IScannerRepository {
  ScannerRepository({required IScannerDatasource datasource})
      : _datasource = datasource;

  final IScannerDatasource _datasource;

  /// Initiates a scan and returns the result.
  ///
  /// This method calls the [scan] method of the datasource to perform the
  /// scanning operation. It handles errors by returning appropriate [ScannerFailure]
  /// types:
  /// - [PlatformScannerFailure] for platform-specific scanning issues.
  /// - [UnknownScannerFailure] for other unexpected errors.
  ///
  /// Returns a [FutureResult] containing the scan result (a string) or an error.
  @override
  FutureResult<String, ScannerFailure> scan() async {
    try {
      final scan = await _datasource.scan();
      return Success(scan);
    } on PlatformException catch (_) {
      return Failure(const PlatformScannerFailure());
    } on Exception catch (e) {
      return Failure(UnknownScannerFailure(error: e));
    }
  }
}
