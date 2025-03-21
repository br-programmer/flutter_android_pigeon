import 'package:flutter/services.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

class ScannerRepository implements IScannerRepository {
  ScannerRepository({required IScannerDatasource datasource})
      : _datasource = datasource;

  final IScannerDatasource _datasource;

  @override
  FutureResult<String, ScannerFailure> scan() async {
    try {
      final scan = await _datasource.scan();
      return Success(scan);
    } on PlatformException catch (_) {
      return Failure(const PlatformScannerFailure());
    } on Exception catch (e) {
      return Failure(UnknownScannerFailure(error: e));
    }
  }
}
