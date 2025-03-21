import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/storage/local_storage_api.g.dart';

/// A local implementation of the [IStorageDatasource] interface.
///
/// This class interacts with the [ILocalStorageApi] to manage scan data locally.
/// It provides methods to retrieve stored scans, save new scan values, and clear
/// the stored data. The class delegates these tasks to the provided API instance.
///
/// - [scans]: Retrieves a list of stored scan values from the local storage.
/// - [save]: Saves a new scan value to the local storage.
/// - [clear]: Clears all stored scan data from the local storage.
class LocalStorageDatasource implements IStorageDatasource {
  LocalStorageDatasource({required ILocalStorageApi api}) : _api = api;

  final ILocalStorageApi _api;

  /// Retrieves a list of stored scan values.
  ///
  /// This method calls the `scans` method of the [ILocalStorageApi] to retrieve
  /// all the stored scan data (such as QR codes or barcodes). It returns the
  /// stored data as a list of strings.
  @override
  Future<List<String>> scans() => _api.scans();

  /// Saves a new scan value to the local storage.
  ///
  /// This method calls the `save` method of the [ILocalStorageApi] to store the
  /// provided scan value (usually a string representing a QR code or barcode).
  @override
  Future<void> save(String value) => _api.save(value);

  /// Clears all stored scan data from the local storage.
  ///
  /// This method calls the `clear` method of the [ILocalStorageApi] to remove
  /// all previously stored scan data.
  @override
  Future<void> clear() => _api.clear();
}
