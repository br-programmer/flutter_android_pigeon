/// Abstract interface for a storage datasource.
///
/// This interface defines the contract for a storage datasource that
/// handles operations related to storing, retrieving, and clearing scan data.
///
/// The [scans] method retrieves a list of stored scans,
/// the [save] method stores a new scan value, and
/// the [clear] method removes all stored scan data.
abstract interface class IStorageDatasource {
  /// Retrieves a list of stored scan values.
  ///
  /// This method fetches all the scan data that has been stored previously.
  /// The returned list typically represents a collection of scanned values
  /// (e.g., QR codes, barcodes).
  Future<List<String>> scans();

  /// Saves a new scan value.
  ///
  /// This method stores a new scan value in the storage. The value could be
  /// a QR code, barcode, or any other type of scan result represented as a string.
  Future<void> save(String value);

  /// Clears all stored scan data.
  ///
  /// This method removes all previously saved scan values from the storage,
  /// effectively resetting the stored data.
  Future<void> clear();
}
