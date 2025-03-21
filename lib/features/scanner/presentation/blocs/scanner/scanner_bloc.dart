import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

/// A BLoC that manages the scanning process for QR codes or barcodes.
///
/// The [ScannerBloc] listens for the [StartScanRequested] event to initiate
/// the scanning process. It interacts with the [IScannerRepository] to perform
/// the scan, and emits different states based on the result, such as success or error.
///
/// The BLoC emits the following states:
/// - [ScannerLoading]: Indicates that the scanner is in the process of scanning.
/// - [ScannerSuccess]: Indicates that the scan was successful and contains the scanned value.
/// - [ScannerError]: Indicates that an error occurred during the scan, containing the error details.
class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc(
    super.initialState, {
    required IScannerRepository scannerRepository,
  }) : _scannerRepository = scannerRepository {
    on<StartScanRequested>(_onStartScanRequested);
  }

  final IScannerRepository _scannerRepository;

  /// Handles the [StartScanRequested] event.
  ///
  /// This method is called when the user initiates a scan. It first emits
  /// the [ScannerLoading] state to indicate that the scanning process has started.
  /// Then it calls the scan method of the [IScannerRepository] to perform the scan.
  /// Based on the result of the scan, it emits either [ScannerSuccess] if the scan
  /// succeeds or [ScannerError] if there is an error.
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
