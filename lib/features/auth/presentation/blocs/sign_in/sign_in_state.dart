part of 'sign_in_bloc.dart';

/// Base class for all states emitted by [SignInBloc].
///
/// This class is the base for all states related to the sign-in process.
/// It extends [Equatable] to enable value-based equality checks, which helps
/// to ensure that the UI rebuilds only when the state changes meaningfully.
sealed class SignInState extends Equatable {
  /// Const constructor for all [SignInState] subclasses.
  const SignInState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any sign-in action has occurred.
///
/// This state is used when the sign-in screen is first shown, before
/// any authentication process begins.
class SignInInitial extends SignInState {
  const SignInInitial();
}

/// State emitted while the authentication process is ongoing.
///
/// This state is used to show a loading indicator or disable UI elements
/// while authentication is being processed.
class SignInLoading extends SignInState {
  const SignInLoading();
}

/// State emitted when authentication is completed successfully.
///
/// This state indicates that the user has been authenticated and can
/// proceed to the app. It signifies the successful completion of the
/// sign-in process.
class SignInSuccess extends SignInState {
  const SignInSuccess();
}

/// State emitted when authentication fails.
///
/// This state carries an [AuthFailure] instance, which details the reason
/// for the authentication failure. It is typically used to display error
/// messages or offer retry options to the user.
class SignInError extends SignInState {
  /// Creates a [SignInError] with the given [failure].
  const SignInError(this.failure);

  /// The reason why authentication failed.
  final AuthFailure failure;

  @override
  List<Object?> get props => [failure];
}

/// State emitted when the sign-in process is cancelled.
///
/// This state is used when the user cancels the sign-in process, such as
/// when biometric authentication is dismissed or the user chooses to
/// cancel the operation.
class SignInCancelled extends SignInState {
  const SignInCancelled();
}

/// State emitted when biometric authentication is unavailable.
///
/// This could be due to a lack of hardware, missing permissions, or the
/// method being unsupported. It carries an [AuthFailure] that explains
/// the reason for the unavailability of biometric authentication.
class SignInUnavailable extends SignInState {
  /// Creates a [SignInUnavailable] with the given [failure].
  const SignInUnavailable(this.failure);

  /// The reason why authentication is unavailable.
  final AuthFailure failure;

  @override
  List<Object?> get props => [failure];
}
