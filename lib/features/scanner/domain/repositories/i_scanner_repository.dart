import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// Abstract interface for a scanner repository.
///
/// This interface defines the contract for a scanner repository that handles
/// the scanning process. The repository is responsible for performing the scan
/// and returning the result, encapsulated in a [FutureResult] to indicate success
/// or failure, based on the [ScannerFailure] error type.
///
/// The [scan] method initiates the scanning process and returns the result as a
/// [FutureResult] containing either the scanned data (as a string) on success,
/// or a [ScannerFailure] error if the scan fails.
abstract interface class IScannerRepository {
  /// Initiates the scanning process and returns the result.
  ///
  /// This method is responsible for scanning data, such as a QR code or barcode,
  /// and returning the result as a string. The result is wrapped in a [FutureResult],
  /// which may either be a [Success] containing the scan result or a [Failure] containing
  /// an error, such as [ScannerFailure].
  FutureResult<String, ScannerFailure> scan();
}
