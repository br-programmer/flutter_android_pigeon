import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/auth/auth.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// [SignInBloc] manages the biometric sign-in flow.
///
/// It listens to sign-in events and emits states based on the result
/// of the authentication process using functional programming principles
/// with the [Result] type.
///
/// Flow:
/// 1. Listens to [AuthenticateRequested] event.
/// 2. Emits [SignInLoading].
/// 3. Calls the [_authRepository.authenticate()] method.
/// 4. Emits [SignInSuccess] if authentication succeeds, or
///    [SignInError] with [AuthFailure] if it fails.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  /// Constructs [SignInBloc] with the initial state set to [SignInInitial]
  /// and registers the event handler for [AuthenticateRequested].
  SignInBloc(
    super.initialState, {
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository {
    on<AuthenticateRequested>(_onAuthenticateRequested);
  }

  /// Repository that handles biometric authentication.
  final IAuthRepository _authRepository;

  /// Handles [AuthenticateRequested] events.
  ///
  /// Emits [SignInLoading], then calls the authentication method.
  /// Based on the [Result], it emits:
  /// - [SignInSuccess] on successful authentication.
  /// - [SignInError] with [AuthFailure] on failure.
  Future<void> _onAuthenticateRequested(
    AuthenticateRequested event,
    Emitter<SignInState> emit,
  ) async {
    final (title, subtitle, cancel, methods) = (
      event.title,
      event.subTitle,
      event.cancel,
      event.methods,
    );

    emit(const SignInLoading());
    final biometric = _selectBestBiometric(methods);
    if (biometric != null) {
      final canBioResult = await _authRepository.canAuthenticate(biometric);
      if (canBioResult case Success(:final data) when data) {
        final authBioResult = await _authRepository.authenticate(
          method: biometric,
          title: title,
          subtitle: subtitle,
          cancel: cancel,
        );
        final signInSuccessState = switch (authBioResult) {
          Success() => const SignInSuccess(),
          Failure(:final error) when error.cancelled => const SignInCancelled(),
          Failure() => null,
        };
        if (signInSuccessState != null) {
          emit(signInSuccessState);
          return;
        }
      }
      if (canBioResult case Failure(:final error)) {
        emit(SignInUnavailable(error));
      }
    }
    await Future<void>.microtask(() {});
    const deviceCredential = AuthMethod.deviceCredential;
    if (methods.contains(deviceCredential)) {
      final canDeviceCredentialResult = await _authRepository.canAuthenticate(
        deviceCredential,
      );
      if (canDeviceCredentialResult case Success(:final data) when data) {
        final authCredentialResult = await _authRepository.authenticate(
          method: deviceCredential,
          title: title,
          subtitle: subtitle,
        );
        final authState = switch (authCredentialResult) {
          Success() => const SignInSuccess(),
          Failure(:final error) => SignInError(error),
        };
        emit(authState);
        return;
      }
      if (canDeviceCredentialResult case Failure(:final error)) {
        emit(SignInUnavailable(error));
        return;
      }
    }

    emit(SignInError(AuthFailure.fromCode('no_method_available')));
  }

  AuthMethod? _selectBestBiometric(List<AuthMethod> methods) {
    return switch (methods) {
      final m when m.contains(AuthMethod.biometricStrong) =>
        AuthMethod.biometricStrong,
      final m when m.contains(AuthMethod.biometricWeak) =>
        AuthMethod.biometricWeak,
      _ => null,
    };
  }
}
