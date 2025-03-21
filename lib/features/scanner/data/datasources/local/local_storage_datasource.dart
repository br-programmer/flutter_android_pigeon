import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/storage/local_storage_api.g.dart';

class LocalStorageDatasource implements IStorageDatasource {
  LocalStorageDatasource({required ILocalStorageApi api}) : _api = api;

  final ILocalStorageApi _api;

  @override
  Future<List<String>> scans() => _api.scans();

  @override
  Future<void> save(String value) => _api.save(value);

  @override
  Future<void> clear() => _api.clear();
}
