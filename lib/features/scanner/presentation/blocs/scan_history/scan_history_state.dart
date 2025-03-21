part of 'scan_history_bloc.dart';

sealed class ScanHistoryState {
  const ScanHistoryState();
}

class ScanHistoryInitial extends ScanHistoryState {
  const ScanHistoryInitial();
}

class ScanHistoryLoading extends ScanHistoryState {
  const ScanHistoryLoading();
}

class ScanHistoryLoaded extends ScanHistoryState {
  const ScanHistoryLoaded(this.scans);
  final List<String> scans;
}

class ScanHistoryError extends ScanHistoryState {
  const ScanHistoryError(this.failure);
  final StorageFailure failure;
}

extension ScanHistoryStateX on ScanHistoryState {
  List<String> get scans => switch (this) {
        ScanHistoryLoaded(:final scans) => scans,
        _ => [],
      };
}
