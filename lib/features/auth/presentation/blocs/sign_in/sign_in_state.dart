part of 'sign_in_bloc.dart';

/// Base class for all states emitted by [SignInBloc].
///
/// Extends [Equatable] to enable value-based equality checks,
/// ensuring efficient UI rebuilds when state changes.
sealed class SignInState extends Equatable {
  /// Const constructor for all [SignInState] subclasses.
  const SignInState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any sign-in action has occurred.
///
/// This is the default state when the sign-in screen is first shown.
class SignInInitial extends SignInState {
  const SignInInitial();
}

/// State emitted while the authentication process is ongoing.
///
/// Typically used to show a loading indicator or disable inputs.
class SignInLoading extends SignInState {
  const SignInLoading();
}

/// State emitted when authentication is completed successfully.
///
/// Indicates the user has been authenticated and can proceed to the app.
class SignInSuccess extends SignInState {
  const SignInSuccess();
}

/// State emitted when authentication fails.
///
/// Carries an [AuthFailure] detailing the reason for failure.
/// Use this state to show error messages or retry options.
class SignInError extends SignInState {
  /// Creates a [SignInError] with the given [failure].
  const SignInError(this.failure);

  /// The reason why authentication failed.
  final AuthFailure failure;

  @override
  List<Object?> get props => [failure];
}

class SignInCancelled extends SignInState {
  const SignInCancelled();
}

/// State emitted when biometric authentication is unavailable.
///
/// This could be due to lack of hardware, permissions, or unsupported method.
/// Carries an [AuthFailure] explaining the unavailability.
class SignInUnavailable extends SignInState {
  /// Creates a [SignInUnavailable] with the given [failure].
  const SignInUnavailable(this.failure);

  /// The reason why authentication is unavailable.
  final AuthFailure failure;

  @override
  List<Object?> get props => [failure];
}
