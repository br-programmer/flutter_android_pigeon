import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc(
    super.initialState, {
    required IScannerRepository scannerRepository,
  }) : _scannerRepository = scannerRepository {
    on<StartScanRequested>(_onStartScanRequested);
  }

  final IScannerRepository _scannerRepository;

  Future<void> _onStartScanRequested(
    StartScanRequested event,
    Emitter<ScannerState> emit,
  ) async {
    emit(const ScannerLoading());
    final result = await _scannerRepository.scan();
    final state = switch (result) {
      Success(:final data) => ScannerSuccess(data),
      Failure(:final error) => ScannerError(error),
    };
    emit(state);
  }
}
