import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

extension on String? {
  bool get splash => this?.contains(QrBiometricRoutes.splash.path) ?? false;
  bool get auth => this?.contains(QrBiometricRoutes.auth.path) ?? false;
}

class QrBiometricRouter {
  const QrBiometricRouter._();

  static List<RouteBase> get routes {
    return [
      GoRoute(
        path: QrBiometricRoutes.splash.path,
        name: QrBiometricRoutes.splash.name,
        builder: SplashScreen.builder,
      ),
      GoRoute(
        path: QrBiometricRoutes.auth.path,
        name: QrBiometricRoutes.auth.name,
        builder: AuthScreen.builder,
      ),
      GoRoute(
        path: QrBiometricRoutes.scanner.path,
        name: QrBiometricRoutes.scanner.name,
        builder: ScanListScreen.builder,
      ),
    ];
  }

  static String? redirect(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthBloc>().state;
    final (loggedIn, loading) = switch (authState) {
      AuthInitial() || AuthLoading() => (false, true),
      Authenticated() => (true, false),
      _ => (false, false),
    };
    if (loading) return null;
    final fullPath = state.fullPath;
    return switch (loggedIn) {
      true when fullPath.splash || fullPath.auth =>
        QrBiometricRoutes.scanner.path,
      false when !fullPath.auth => QrBiometricRoutes.auth.path,
      _ => null,
    };
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(this.stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }
  final Stream<AuthState> stream;
  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
