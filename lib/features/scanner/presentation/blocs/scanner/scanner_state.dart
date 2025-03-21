part of 'scanner_bloc.dart';

/// Base class for all states emitted by the scanner BLoC.
///
/// This class represents the different states that the [ScannerBloc] can emit
/// during the scanning process, such as when the scanner is initializing,
/// loading, successfully scanning, or encountering an error.
sealed class ScannerState {
  const ScannerState();
}

/// State representing the initial state before any scan has occurred.
///
/// This state is emitted when the scanning process has not started yet,
/// indicating that the scanner is in its initial setup.
class ScannerInitial extends ScannerState {
  const ScannerInitial();
}

/// State representing that the scanner is currently in the loading process.
///
/// This state is emitted when the scanner is actively scanning, such as when
/// the app is waiting for the user to scan a QR code or barcode.
class ScannerLoading extends ScannerState {
  const ScannerLoading();
}

/// State representing that the scanning was successful.
///
/// This state is emitted when the scanner successfully captures a value (e.g.,
/// QR code or barcode result). It contains the scanned value as a string.
///
/// - `value`: The string representing the result of the scan (e.g., the content
///   of a QR code or barcode).
class ScannerSuccess extends ScannerState {
  const ScannerSuccess(this.value);

  final String value;
}

/// State representing that an error occurred during the scanning process.
///
/// This state is emitted when an error happens during scanning. It contains a
/// [ScannerFailure] instance that provides details about the error.
///
/// - `failure`: An instance of [ScannerFailure] that describes the error that
///   caused the scan to fail.
class ScannerError extends ScannerState {
  const ScannerError(this.failure);

  final ScannerFailure failure;
}
