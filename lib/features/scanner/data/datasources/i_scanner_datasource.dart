/// Abstract interface for a scanner datasource.
///
/// This interface defines the contract for a scanner datasource that
/// performs scanning operations. Classes implementing this interface should
/// provide the functionality to initiate a scan and return the result.
///
/// The [scan] method is expected to perform the scanning operation and
/// return a string result, which could represent a scanned QR code or barcode.
abstract interface class IScannerDatasource {
  /// Initiates a scan and returns the result as a string.
  ///
  /// The returned string typically represents the result of a scan, such as
  /// the data from a QR code or barcode. The implementation should define
  /// how the scan is performed (e.g., using camera APIs or scanning hardware).
  Future<String> scan();
}
