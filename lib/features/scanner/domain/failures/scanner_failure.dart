sealed class ScannerFailure {
  const ScannerFailure();
}

class PlatformScannerFailure extends ScannerFailure {
  const PlatformScannerFailure();
}

class UnknownScannerFailure extends ScannerFailure {
  const UnknownScannerFailure({required this.error});
  final Object error;
}
