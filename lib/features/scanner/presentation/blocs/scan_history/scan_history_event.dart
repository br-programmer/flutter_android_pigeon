part of 'scan_history_bloc.dart';

/// Base class for all events related to the scan history.
///
/// This class serves as the parent for events that the `ScanHistoryBloc`
/// can receive, which trigger actions to manage the scan history.
sealed class ScanHistoryEvent {
  const ScanHistoryEvent();
}

/// Event triggered to load the scan history.
///
/// This event is dispatched to the `ScanHistoryBloc` to initiate the process
/// of loading the stored scan data (e.g., QR codes or barcodes). It fetches
/// the saved scan history for display in the UI.
class LoadScanHistory extends ScanHistoryEvent {
  const LoadScanHistory();
}

/// Event triggered to save a new scan.
///
/// This event is dispatched to the `ScanHistoryBloc` when a new scan (e.g.,
/// QR code or barcode result) is available and needs to be saved. The scan
/// value is passed as a parameter.
///
/// - `value`: A string representing the scan result (e.g., the content of a QR code).
class SaveScan extends ScanHistoryEvent {
  const SaveScan(this.value);
  final String value;
}

/// Event triggered to clear the scan history.
///
/// This event is dispatched to the `ScanHistoryBloc` to remove all the
/// previously saved scan data from the storage, effectively resetting the scan history.
class ClearScanHistory extends ScanHistoryEvent {
  const ClearScanHistory();
}
