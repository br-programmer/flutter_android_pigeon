import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// Abstract interface for a storage repository.
///
/// This interface defines the contract for a storage repository that handles
/// operations related to storing, retrieving, and clearing scan data. The
/// repository uses [FutureResult] to indicate success or failure in each operation,
/// with [StorageFailure] used to represent potential errors.
///
/// The methods include:
/// - [scans]: Retrieves a list of stored scan values.
/// - [save]: Saves a new scan value.
/// - [clear]: Clears all stored scan data.
abstract interface class IStorageRepository {
  /// Retrieves a list of stored scan values.
  ///
  /// This method retrieves all scan data that has been saved previously. The
  /// returned result is wrapped in a [FutureResult], where the result is a
  /// list of strings (scan values) on success, or a [StorageFailure] if an error occurs.
  FutureResult<List<String>, StorageFailure> scans();

  /// Saves a new scan value to the storage.
  ///
  /// This method stores a new scan value (usually a QR code or barcode) in
  /// the storage. The result is wrapped in a [FutureResult], with a
  /// [StorageFailure] in case of an error during the saving process.
  FutureResult<void, StorageFailure> save(String value);

  /// Clears all stored scan data from the storage.
  ///
  /// This method removes all saved scan values from the storage. The result
  /// is wrapped in a [FutureResult], with a [StorageFailure] if an error
  /// occurs during the clearing process.
  FutureResult<void, StorageFailure> clear();
}
