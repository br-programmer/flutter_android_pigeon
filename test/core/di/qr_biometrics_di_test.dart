import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/biometric/biometrics_api.g.dart';
import 'package:qr_biometrics_app/pigeon/scanner/qr_scanner_api.g.dart';
import 'package:qr_biometrics_app/pigeon/session/session_api.g.dart';
import 'package:qr_biometrics_app/pigeon/storage/local_storage_api.g.dart';

void main() {
  testWidgets('QrBiometricsDi injects all dependencies correctly',
      (tester) async {
    const testKey = Key('test_widget');

    // Declare instances to be assigned in widget tree
    late IBiometricsApi biometricsApiInstance;
    late IAuthDatasource authDatasourceInstance;
    late IAuthRepository authRepositoryInstance;

    late ISessionApi sessionApiInstance;
    late ISessionDatasource sessionDatasourceInstance;
    late ISessionRepository sessionRepositoryInstance;

    late ILocalStorageApi localStorageApiInstance;
    late IQrScannerApi qrScannerApiInstance;
    late IStorageDatasource storageDatasourceInstance;
    late IScannerDatasource scannerDatasourceInstance;
    late IStorageRepository storageRepositoryInstance;
    late IScannerRepository scannerRepositoryInstance;

    await tester.pumpWidget(
      QrBiometricsDi(
        child: Builder(
          builder: (context) {
            // Auth-related
            biometricsApiInstance = context.read<IBiometricsApi>();
            authDatasourceInstance = context.read<IAuthDatasource>();
            authRepositoryInstance = context.read<IAuthRepository>();

            // Session-related
            sessionApiInstance = context.read<ISessionApi>();
            sessionDatasourceInstance = context.read<ISessionDatasource>();
            sessionRepositoryInstance = context.read<ISessionRepository>();

            // Scanner & Storage-related
            localStorageApiInstance = context.read<ILocalStorageApi>();
            qrScannerApiInstance = context.read<IQrScannerApi>();
            storageDatasourceInstance = context.read<IStorageDatasource>();
            scannerDatasourceInstance = context.read<IScannerDatasource>();
            storageRepositoryInstance = context.read<IStorageRepository>();
            scannerRepositoryInstance = context.read<IScannerRepository>();

            return const MaterialApp(key: testKey);
          },
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);

    // Validate auth dependencies
    expect(biometricsApiInstance, isA<IBiometricsApi>());
    expect(authDatasourceInstance, isA<AuthLocalDatasource>());
    expect(authRepositoryInstance, isA<AuthRepository>());

    // Validate session dependencies
    expect(sessionApiInstance, isA<ISessionApi>());
    expect(sessionDatasourceInstance, isA<SessionLocalDatasource>());
    expect(sessionRepositoryInstance, isA<SessionRepository>());

    // Validate scanner & storage dependencies
    expect(localStorageApiInstance, isA<ILocalStorageApi>());
    expect(qrScannerApiInstance, isA<IQrScannerApi>());
    expect(storageDatasourceInstance, isA<LocalStorageDatasource>());
    expect(scannerDatasourceInstance, isA<LocalScannerDatasource>());
    expect(storageRepositoryInstance, isA<StorageRepository>());
    expect(scannerRepositoryInstance, isA<ScannerRepository>());
  });
}
