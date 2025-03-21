import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// Extension on `String?` to provide convenient checks for specific routes in the QrBiometrics app.
///
/// This extension adds two properties to `String?` to check if the current string contains
/// the paths for the splash and authentication routes.
///
/// - `splash`: Returns `true` if the string contains the path for the splash screen route.
/// - `auth`: Returns `true` if the string contains the path for the authentication screen route.
extension on String? {
  bool get splash => this?.contains(QrBiometricRoutes.splash.path) ?? false;
  bool get auth => this?.contains(QrBiometricRoutes.auth.path) ?? false;
}

/// A utility class that handles routing and redirection logic for the QrBiometrics app.
///
/// This class contains:
/// - A static getter `routes` that provides the routes for splash, auth, and scanner screens.
/// - A static method `redirect` to handle the redirection based on the user's authentication state.
///
/// The redirection logic ensures that the user is sent to the appropriate screen based on
/// their login status. If the user is logged in, they are redirected to the scanner screen
/// when trying to access the splash or auth screen. If they are not logged in, they are
/// redirected to the auth screen.
class QrBiometricRouter {
  const QrBiometricRouter._();

  /// Returns the list of defined routes for the QrBiometrics app.
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

  /// Redirect logic based on the user's authentication state.
  ///
  /// If the user is authenticated, they will be redirected to the scanner screen
  /// when trying to access the splash or auth screen. If the user is not authenticated,
  /// they will be redirected to the auth screen.
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

/// A utility class that listens to changes in the authentication state and notifies
/// listeners when the state changes.
///
/// This class is used by `GoRouter` to refresh the navigation when the authentication
/// state changes. It listens to the stream of `AuthState` and triggers the listeners
/// when there is a change.
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
