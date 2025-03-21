import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/biometric/biometrics_api.g.dart';
import 'package:qr_biometrics_app/pigeon/scanner/qr_scanner_api.g.dart';
import 'package:qr_biometrics_app/pigeon/session/session_api.g.dart';
import 'package:qr_biometrics_app/pigeon/storage/local_storage_api.g.dart';

/// The `QrBiometricsDi` widget is responsible for setting up dependency injection
/// for the QrBiometrics application. It uses `MultiRepositoryProvider` to provide
/// various repositories and data sources to the app, ensuring that all the required
/// dependencies are available throughout the widget tree.
///
/// This widget provides multiple repositories related to authentication, session
/// management, local storage, and QR scanning. It uses the `RepositoryProvider` to
/// inject these dependencies lazily, meaning they are only created when needed.
/// The `child` widget is passed as the root of the widget tree, where these
/// dependencies are accessible for the entire app.
///
/// It ensures that components like biometrics, session, authentication, storage,
/// and scanner APIs are available to be injected where needed, following best
/// practices for managing complex dependencies in Flutter apps.
class QrBiometricsDi extends StatelessWidget {
  const QrBiometricsDi({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => IBiometricsApi(),
          lazy: true,
        ),
        RepositoryProvider<IAuthDatasource>(
          create: (context) => AuthLocalDatasource(api: context.read()),
          lazy: true,
        ),
        RepositoryProvider<IAuthRepository>(
          create: (context) => AuthRepository(dataSource: context.read()),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => ISessionApi(),
          lazy: true,
        ),
        RepositoryProvider<ISessionDatasource>(
          create: (context) => SessionLocalDatasource(api: context.read()),
          lazy: true,
        ),
        RepositoryProvider<ISessionRepository>(
          create: (context) => SessionRepository(dataSource: context.read()),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => ILocalStorageApi(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => IQrScannerApi(),
          lazy: true,
        ),
        RepositoryProvider<IStorageDatasource>(
          create: (context) => LocalStorageDatasource(api: context.read()),
          lazy: true,
        ),
        RepositoryProvider<IScannerDatasource>(
          create: (context) => LocalScannerDatasource(api: context.read()),
          lazy: true,
        ),
        RepositoryProvider<IStorageRepository>(
          create: (context) => StorageRepository(datasource: context.read()),
          lazy: true,
        ),
        RepositoryProvider<IScannerRepository>(
          create: (context) => ScannerRepository(datasource: context.read()),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
