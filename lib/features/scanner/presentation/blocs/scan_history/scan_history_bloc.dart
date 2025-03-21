import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

part 'scan_history_event.dart';
part 'scan_history_state.dart';

/// A BLoC that manages the scan history in the app.
///
/// This BLoC listens for events related to loading, saving, and clearing the
/// scan history, which is stored using the [IStorageRepository]. Based on the
/// result of these actions, the BLoC emits different states to update the UI.
/// It uses functional programming principles with the [Result] type to handle
/// success and failure cases in a structured way.
///
/// The BLoC handles the following events:
/// - [LoadScanHistory]: Loads the stored scan data.
/// - [SaveScan]: Saves a new scan to the history.
/// - [ClearScanHistory]: Clears all stored scan data.
class ScanHistoryBloc extends Bloc<ScanHistoryEvent, ScanHistoryState> {
  ScanHistoryBloc(
    super.initialState, {
    required IStorageRepository storageRepository,
  }) : _storageRepository = storageRepository {
    on<LoadScanHistory>(_onLoad);
    on<SaveScan>(_onSave);
    on<ClearScanHistory>(_onClear);
  }

  final IStorageRepository _storageRepository;

  /// Handles the [LoadScanHistory] event.
  ///
  /// This method is called when the app needs to load the stored scan data.
  /// It fetches the scan history from the [IStorageRepository] and emits the
  /// corresponding state:
  /// - [ScanHistoryLoading] before attempting to load the data.
  /// - [ScanHistoryLoaded] if the scans are successfully loaded.
  /// - [ScanHistoryError] if there is an error during loading.
  Future<void> _onLoad(
    LoadScanHistory event,
    Emitter<ScanHistoryState> emit,
  ) async {
    emit(const ScanHistoryLoading());
    final result = await _storageRepository.scans();
    final state = switch (result) {
      Success(:final data) => ScanHistoryLoaded(data),
      Failure(:final error) => ScanHistoryError(error),
    };
    emit(state);
  }

  /// Handles the [SaveScan] event.
  ///
  /// This method is called when a new scan needs to be saved. It updates the
  /// UI by emitting the current state with the new scan value, and then attempts
  /// to save the scan using the [IStorageRepository]. If saving fails, the state
  /// reverts to the previous list of scans.
  Future<void> _onSave(
    SaveScan event,
    Emitter<ScanHistoryState> emit,
  ) async {
    final scans = [...this.state.scans];
    emit(ScanHistoryLoaded([...scans, event.value]));
    final result = await _storageRepository.save(event.value);
    final state = switch (result) {
      Success() => this.state,
      Failure() => ScanHistoryLoaded(scans),
    };
    emit(state);
  }

  /// Handles the [ClearScanHistory] event.
  ///
  /// This method is called when the user requests to clear the scan history.
  /// It clears the stored scan data by calling the [IStorageRepository]. If
  /// clearing the data fails, the state reverts to the previous list of scans.
  Future<void> _onClear(
    ClearScanHistory event,
    Emitter<ScanHistoryState> emit,
  ) async {
    final scans = [...this.state.scans];
    emit(const ScanHistoryLoaded([]));
    final result = await _storageRepository.clear();
    final state = switch (result) {
      Success() => this.state,
      Failure() => ScanHistoryLoaded(scans),
    };
    emit(state);
  }
}
