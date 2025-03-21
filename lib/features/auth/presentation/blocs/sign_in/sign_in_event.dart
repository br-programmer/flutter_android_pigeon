part of 'sign_in_bloc.dart';

/// Base class for all events related to biometric sign-in.
///
/// Extend this class to define specific events handled by [SignInBloc].
sealed class SignInEvent {
  const SignInEvent();
}

/// Event triggered to initiate the biometric authentication process.
///
/// Dispatched to [SignInBloc] to begin the sign-in flow, typically
/// when the user taps a "Sign In" button or performs a similar action.
///
/// Contains the texts used in the native authentication prompt and
/// specifies the [AuthMethod] to be used.
class AuthenticateRequested extends SignInEvent {
  /// Creates an [AuthenticateRequested] event with the provided parameters.
  ///
  /// [title] and [subTitle] define the texts shown in the biometric prompt.
  /// [cancel] optionally overrides the default cancel button text.
  /// [methods] specifies the authentication method to be used.
  const AuthenticateRequested({
    required this.title,
    required this.subTitle,
    this.cancel,
    required this.methods,
  });

  /// Title displayed in the authentication prompt (e.g., "Sign In").
  final String title;

  /// Subtitle displayed in the authentication prompt (e.g., "Use biometrics").
  final String subTitle;

  /// Optional text for the cancel button. Defaults to system text if null.
  final String? cancel;

  /// Authentication method to be used (e.g., biometricStrong, deviceCredential).
  final List<AuthMethod> methods;
}
