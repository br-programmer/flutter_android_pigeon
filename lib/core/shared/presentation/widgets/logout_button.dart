import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/core/core.dart';

/// A button widget that triggers the logout action when pressed.
///
/// This widget provides an `IconButton` with a logout icon. When the button is pressed,
/// it triggers the [AuthSignedOut] event in the [AuthBloc], which handles the
/// sign-out process and updates the authentication state.
///
/// The button is displayed with the default logout icon from the [Icons.logout] set.
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<AuthBloc>().add(
            const AuthSignedOut(),
          ),
      icon: const Icon(Icons.logout),
    );
  }
}
