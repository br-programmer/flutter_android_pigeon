import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// The `AuthScreen` widget handles the authentication flow in the app.
/// It provides an interface to display the authentication methods and
/// listens for authentication success events.
///
/// The `AuthScreen` widget is composed of two main sections:
/// 1. `SignInBloc` for managing the sign-in state.
/// 2. `SignInMethodsBloc` for managing the available authentication methods.
///
/// The widget uses `BlocListener` to listen for successful sign-in states and
/// trigger authentication actions.
///
/// It also uses `MultiBlocProvider` to provide the required BLoCs to the widget tree.
///
/// - `builder`: A static method that initializes and returns the `AuthScreen` widget.
class AuthScreen extends StatelessWidget {
  const AuthScreen._();

  /// Builder method for constructing the `AuthScreen` widget.
  ///
  /// This is used by [GoRouter] to create the `AuthScreen` widget when navigating
  /// to the authentication route.
  static Widget builder(BuildContext _, GoRouterState __) {
    return const AuthScreen._();
  }

  /// Determines if the success listener should be triggered based on the state change.
  ///
  /// This method listens for state transitions where the previous state is
  /// anything and the current state is [SignInSuccess]. When this happens,
  /// the listener will be triggered.
  bool _successListenWhen(SignInState previous, SignInState current) {
    return switch ((previous, current)) {
      (_, SignInSuccess()) => true,
      (_, _) => false,
    };
  }

  /// Listener function that triggers actions based on the authentication state.
  ///
  /// When the [SignInSuccess] state is emitted, it triggers the `AuthBloc`
  /// to add the `AuthSignedIn` event, marking the user as authenticated.
  void _successListener(BuildContext context, SignInState state) {
    final callback = switch (state) {
      SignInSuccess() => () => context.read<AuthBloc>().add(
            const AuthSignedIn(),
          ),
      _ => null,
    };
    callback?.call();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInBloc(
            const SignInInitial(),
            authRepository: context.read(),
          ),
        ),
        BlocProvider(
          create: (_) => SignInMethodsBloc(
            const SignInMethodsInitial(),
            authRepository: context.read(),
          )..add(const SignInMethodsRequested()),
        ),
      ],
      child: BlocListener<SignInBloc, SignInState>(
        listener: _successListener,
        listenWhen: _successListenWhen,
        child: const AuthLayout(),
      ),
    );
  }
}

/// The layout of the authentication screen, displaying different UI
/// elements based on the state of the [SignInMethodsBloc].
///
/// This widget listens to the state of the `SignInMethodsBloc` and
/// displays different widgets based on the state, such as loading indicators,
/// authentication method options, or error states.
class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInMethodsBloc, SignInMethodsState>(
      builder: (_, state) => Scaffold(
        body: SafeArea(
          child: switch (state) {
            SignInMethodsInitial() => sizedBoxShrink,
            SignInMethodsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            SignInMethodsLoaded(:final methods) => AuthMethodLoaded(
                methods: methods,
              ),
            SignInMethodsError() => sizedBoxShrink,
          },
        ),
      ),
    );
  }
}
