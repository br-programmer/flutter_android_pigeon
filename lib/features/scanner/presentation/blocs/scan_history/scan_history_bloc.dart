import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

part 'scan_history_event.dart';
part 'scan_history_state.dart';

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
