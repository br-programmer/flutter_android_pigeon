part of 'scanner_bloc.dart';

sealed class ScannerState {
  const ScannerState();
}

class ScannerInitial extends ScannerState {
  const ScannerInitial();
}

class ScannerLoading extends ScannerState {
  const ScannerLoading();
}

class ScannerSuccess extends ScannerState {
  const ScannerSuccess(this.value);

  final String value;
}

class ScannerError extends ScannerState {
  const ScannerError(this.failure);

  final ScannerFailure failure;
}
