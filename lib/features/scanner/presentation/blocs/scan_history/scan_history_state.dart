part of 'scan_history_bloc.dart';

/// Base class for all states related to the scan history.
///
/// This class represents different states that the `ScanHistoryBloc` can emit
/// during the scan history process. It provides a structured way to manage the
/// loading and retrieval of scan history data.
sealed class ScanHistoryState {
  const ScanHistoryState();
}

/// State indicating that the scan history is in its initial state.
///
/// This is the default state when the `ScanHistoryBloc` is first created,
/// before any scan history has been loaded or requested.
class ScanHistoryInitial extends ScanHistoryState {
  const ScanHistoryInitial();
}

/// State representing that the scan history is being loaded.
///
/// This state is emitted while the scan history data is being fetched.
/// It is typically used to show a loading indicator to the user.
class ScanHistoryLoading extends ScanHistoryState {
  const ScanHistoryLoading();
}

/// State indicating that the scan history has been successfully loaded.
///
/// This state contains a list of scan data (e.g., QR code results). It is emitted
/// when the scan history has been successfully fetched and is available for display.
///
/// - `scans`: A list of strings representing the stored scan data (e.g., QR code values).
class ScanHistoryLoaded extends ScanHistoryState {
  const ScanHistoryLoaded(this.scans);
  final List<String> scans;
}

/// State indicating that an error occurred while loading the scan history.
///
/// This state carries a [StorageFailure] that details the reason for the failure
/// during the scan history retrieval process. It is emitted when an error happens
/// (e.g., failure in reading storage).
///
/// - `failure`: An instance of [StorageFailure] that provides error details.
class ScanHistoryError extends ScanHistoryState {
  const ScanHistoryError(this.failure);
  final StorageFailure failure;
}

/// Extension providing additional helper methods for [ScanHistoryState].
extension ScanHistoryStateX on ScanHistoryState {
  /// Retrieves the list of scans from the current state.
  ///
  /// This method checks if the state is [ScanHistoryLoaded] and returns the list
  /// of scans. If the state is not [ScanHistoryLoaded], it returns an empty list.
  List<String> get scans => switch (this) {
        ScanHistoryLoaded(:final scans) => scans,
        _ => [],
      };
}
