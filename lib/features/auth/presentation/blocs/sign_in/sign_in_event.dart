part of 'sign_in_bloc.dart';

/// Base class for all events related to biometric sign-in.
///
/// This class is the base for events that trigger actions in the `SignInBloc`
/// related to biometric authentication. Specific events for the sign-in flow
/// should extend this class.
sealed class SignInEvent {
  const SignInEvent();
}

/// Event triggered to initiate the biometric authentication process.
///
/// This event is dispatched to the [SignInBloc] to begin the biometric
/// sign-in flow. Typically, it is triggered when the user taps a "Sign In"
/// button or performs a similar action that starts the authentication process.
///
/// It contains the necessary texts for the native authentication prompt and
/// specifies the [AuthMethod] to be used for the authentication.
///
/// - [title] and [subTitle] define the texts shown in the biometric prompt.
/// - [cancel] optionally overrides the default cancel button text. If null,
///   the system's default text is used.
/// - [methods] specifies the available authentication methods (e.g., biometric,
///   device credentials).
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
