import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

abstract interface class IScannerRepository {
  FutureResult<String, ScannerFailure> scan();
}
