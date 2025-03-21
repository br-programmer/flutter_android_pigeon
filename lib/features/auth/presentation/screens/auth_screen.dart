import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const AuthScreen._();
  }

  bool _successListenWhen(SignInState previous, SignInState current) {
    return switch ((previous, current)) {
      (_, SignInSuccess()) => true,
      (_, _) => false,
    };
  }

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
