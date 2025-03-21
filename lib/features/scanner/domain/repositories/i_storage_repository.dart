import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

abstract interface class IStorageRepository {
  FutureResult<List<String>, StorageFailure> scans();
  FutureResult<void, StorageFailure> save(String value);
  FutureResult<void, StorageFailure> clear();
}
