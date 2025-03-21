import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/gen/assets.gen.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

/// A screen that displays a splash or loading page while the app is validating the user's session.
///
/// The [SplashScreen] is shown when the app is starting or when a session validation is required.
/// It contains a logo, a validation message, and a loading indicator while the authentication or
/// session check is in progress.
///
/// The screen includes:
/// - A logo image representing the app.
/// - A message indicating that the session is being validated.
/// - A [CircularProgressIndicator] that shows the loading state.
class SplashScreen extends StatelessWidget {
  const SplashScreen._();

  /// Builder method for constructing the [SplashScreen] widget.
  ///
  /// This is used by [GoRouter] to create the `SplashScreen` widget when navigating
  /// to the splash screen route.
  static Widget builder(BuildContext _, GoRouterState __) {
    return const SplashScreen._();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Displays the logo image centered on the screen.
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.auth.image(
                    width: context.qrAppSize.width * .5,
                  ),
                  Text(context.texts.auth.validateSession),
                ],
              ),
            ),
            // Displays a loading spinner while the session is being validated.
            const Center(child: CircularProgressIndicator()),
            gap8,
          ],
        ),
      ),
    );
  }
}
