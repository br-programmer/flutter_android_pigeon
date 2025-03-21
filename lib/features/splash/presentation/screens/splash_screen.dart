import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/gen/assets.gen.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen._();

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
            const Center(child: CircularProgressIndicator()),
            gap8,
          ],
        ),
      ),
    );
  }
}
