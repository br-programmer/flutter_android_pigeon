part of 'scanner_bloc.dart';

/// Base class for all events related to the scanner.
///
/// This class serves as the parent for events that the [ScannerBloc]
/// can receive. Specific events related to the scanning process should
/// extend this class.
sealed class ScannerEvent {
  const ScannerEvent();
}

/// Event triggered to start the scanning process.
///
/// This event is dispatched to the [ScannerBloc] to begin the scanning
/// operation, such as when the user initiates a scan by tapping a button
/// or performing an action to start scanning.
///
/// This event does not contain any additional parameters, as it is simply
/// used to trigger the scanning process.
class StartScanRequested extends ScannerEvent {
  const StartScanRequested();
}
