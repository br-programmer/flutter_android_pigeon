/// A base class for all scanner-related failures.
///
/// This class serves as the parent for all failure types that may occur during
/// the scanning process. It allows for structured handling of errors related
/// to scanning operations.
sealed class ScannerFailure {
  const ScannerFailure();
}

/// Represents a platform-specific failure during scanning.
///
/// This class is used when the scanning process fails due to platform-specific
/// issues, such as permissions or hardware issues. It does not include detailed
/// error information.
class PlatformScannerFailure extends ScannerFailure {
  const PlatformScannerFailure();
}

/// Represents an unknown or unexpected failure during scanning.
///
/// This class is used when an unexpected error occurs during the scanning process.
/// It holds the original error object for further inspection or debugging.
///
/// - `error`: The error that caused the failure, which can be any type of object.
class UnknownScannerFailure extends ScannerFailure {
  const UnknownScannerFailure({required this.error});
  final Object error;
}
