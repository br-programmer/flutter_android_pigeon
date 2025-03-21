part of 'scan_history_bloc.dart';

sealed class ScanHistoryEvent {
  const ScanHistoryEvent();
}

class LoadScanHistory extends ScanHistoryEvent {
  const LoadScanHistory();
}

class SaveScan extends ScanHistoryEvent {
  const SaveScan(this.value);
  final String value;
}

class ClearScanHistory extends ScanHistoryEvent {
  const ClearScanHistory();
}
