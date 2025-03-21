import 'package:flutter/services.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// A concrete implementation of the [IStorageRepository] interface.
///
/// This class handles storage operations by interacting with a datasource that
/// manages the underlying storage (e.g., local database or file system). It provides
/// methods to store, retrieve, and clear scan data, and handles errors using the
/// [StorageFailure] type. The repository is responsible for converting raw errors
/// into specific failure types, which are then returned wrapped in a [FutureResult].
///
/// The methods include:
/// - [save]: Saves a new scan value.
/// - [scans]: Retrieves a list of stored scan values.
/// - [clear]: Clears all stored scan data.
class StorageRepository implements IStorageRepository {
  StorageRepository({required IStorageDatasource datasource})
      : _datasource = datasource;

  final IStorageDatasource _datasource;

  /// Saves a new scan value to the storage.
  ///
  /// This method calls the [save] method of the datasource to store the provided
  /// scan value (e.g., a QR code or barcode). It handles errors by returning
  /// appropriate [StorageFailure] types:
  /// - [StorageWriteFailure] for platform-related issues.
  /// - [UnknownStorageFailure] for other unexpected errors.
  ///
  /// Returns a [FutureResult] indicating the success or failure of the operation.
  @override
  FutureResult<void, StorageFailure> save(String value) async {
    try {
      await _datasource.save(value);
      return Success(null);
    } on PlatformException catch (_) {
      return Failure(const StorageWriteFailure());
    } on Exception catch (e) {
      return Failure(UnknownStorageFailure(error: e));
    }
  }

  /// Retrieves a list of stored scan values.
  ///
  /// This method calls the [scans] method of the datasource to fetch all stored
  /// scan data (e.g., QR codes or barcodes). It handles errors by returning
  /// appropriate [StorageFailure] types:
  /// - [StorageReadFailure] for platform-related issues.
  /// - [UnknownStorageFailure] for other unexpected errors.
  ///
  /// Returns a [FutureResult] with the list of stored scan values or an error.
  @override
  FutureResult<List<String>, StorageFailure> scans() async {
    try {
      final scans = await _datasource.scans();
      return Success(scans);
    } on PlatformException catch (_) {
      return Failure(const StorageReadFailure());
    } on Exception catch (e) {
      return Failure(UnknownStorageFailure(error: e));
    }
  }

  /// Clears all stored scan data.
  ///
  /// This method calls the [clear] method of the datasource to remove all
  /// previously stored scan data. It handles errors by returning appropriate
  /// [StorageFailure] types:
  /// - [StorageWriteFailure] for platform-related issues.
  /// - [UnknownStorageFailure] for other unexpected errors.
  ///
  /// Returns a [FutureResult] indicating the success or failure of the operation.
  @override
  FutureResult<void, StorageFailure> clear() async {
    try {
      await _datasource.clear();
      return Success(null);
    } on PlatformException catch (_) {
      return Failure(const StorageWriteFailure());
    } on Exception catch (e) {
      return Failure(UnknownStorageFailure(error: e));
    }
  }
}
