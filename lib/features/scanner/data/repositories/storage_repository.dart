import 'package:flutter/services.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

class StorageRepository implements IStorageRepository {
  StorageRepository({required IStorageDatasource datasource})
      : _datasource = datasource;

  final IStorageDatasource _datasource;

  @override
  FutureResult<void, StorageFailure> save(String value) async {
    try {
      await _datasource.save(value);
      return Success(null);
    } on PlatformException catch (_) {
      return Failure(const StorageWriteFailure());
    } on Exception catch (e) {
      return Failure(UnknownStorageFailure(error: e));
    }
  }

  @override
  FutureResult<List<String>, StorageFailure> scans() async {
    try {
      final scans = await _datasource.scans();
      return Success(scans);
    } on PlatformException catch (_) {
      return Failure(const StorageReadFailure());
    } on Exception catch (e) {
      return Failure(UnknownStorageFailure(error: e));
    }
  }

  @override
  FutureResult<void, StorageFailure> clear() async {
    try {
      await _datasource.clear();
      return Success(null);
    } on PlatformException catch (_) {
      return Failure(const StorageWriteFailure());
    } on Exception catch (e) {
      return Failure(UnknownStorageFailure(error: e));
    }
  }
}
