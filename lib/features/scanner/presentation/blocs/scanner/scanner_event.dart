part of 'scanner_bloc.dart';

sealed class ScannerEvent {
  const ScannerEvent();
}

class StartScanRequested extends ScannerEvent {
  const StartScanRequested();
}
