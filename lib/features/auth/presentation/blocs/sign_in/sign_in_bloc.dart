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
/// The flow of the sign-in process is as follows:
/// 1. Listens to the [AuthenticateRequested] event.
/// 2. Emits the [SignInLoading] state to indicate the authentication is in progress.
/// 3. Calls the [_authRepository.authenticate()] method to perform the authentication.
/// 4. Emits [SignInSuccess] if authentication is successful.
/// 5. Emits [SignInError] with an [AuthFailure] if authentication fails.
///
/// This BLoC also handles different types of authentication methods, such as biometrics
/// and device credentials, and manages the result based on which method is chosen.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  /// Constructs [SignInBloc] with the initial state set to [SignInInitial].
  /// Registers the event handler for [AuthenticateRequested] to initiate authentication.
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
  /// This method starts the authentication process by first emitting the [SignInLoading]
  /// state to indicate the authentication is ongoing. It then selects the best biometric
  /// method and proceeds with authentication based on the available methods.
  /// If the authentication succeeds, it emits [SignInSuccess]. If it fails, it emits
  /// [SignInError] with an [AuthFailure] or [SignInCancelled] if the user cancels the process.
  ///
  /// - If biometric authentication fails or is unavailable, it falls back to using
  ///   device credentials if available.
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

    // Try biometric authentication
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

    // Fallback to device credentials if biometric authentication is not available
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

    // No valid method available for authentication
    emit(SignInError(AuthFailure.fromCode('no_method_available')));
  }

  /// Selects the best available biometric authentication method.
  ///
  /// It checks the provided list of [methods] and prioritizes stronger biometric
  /// methods. If [AuthMethod.biometricStrong] is available, it is selected.
  /// If not, it falls back to [AuthMethod.biometricWeak].
  ///
  /// Returns the selected biometric authentication method, or null if none are available.
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
