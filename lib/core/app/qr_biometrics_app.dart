import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

class QrBiometricsApp extends StatelessWidget {
  const QrBiometricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return QrBiometricsDi(
      child: BlocProvider(
        create: (context) => AuthBloc(
          const AuthInitial(),
          sessionRepository: context.read(),
          delay: const Duration(seconds: 3),
        )..add(const AuthCheckRequested()),
        child: RepositoryProvider<GoRouter>(
          create: (context) => GoRouter(
            initialLocation: QrBiometricRoutes.splash.path,
            routes: QrBiometricRouter.routes,
            navigatorKey: GlobalKey<NavigatorState>(),
            debugLogDiagnostics: kDebugMode,
            redirect: QrBiometricRouter.redirect,
            refreshListenable: GoRouterRefreshStream(
              context.read<AuthBloc>().stream,
            ),
          ),
          child: Builder(
            builder: (context) => MaterialApp.router(
              title: 'Qr Biometrics',
              routerConfig: context.read<GoRouter>(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: Colors.white,
              ),
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
            ),
          ),
        ),
      ),
    );
  }
}
