part of 'auth_bloc.dart';

/// Base class for all events handled by [AuthBloc].
///
/// These events manage session verification, sign-in, and sign-out actions.
sealed class AuthEvent {
  const AuthEvent();
}

/// Event triggered during app launch to verify the authentication status.
///
/// Typically dispatched from the splash screen to determine whether to
/// navigate to the sign-in screen or the main application.
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Event triggered when the user successfully signs in.
///
/// This notifies [AuthBloc] to mark the session as authenticated.
class AuthSignedIn extends AuthEvent {
  const AuthSignedIn();
}

/// Event triggered when the user explicitly signs out.
///
/// This notifies [AuthBloc] to clear session data and transition to
/// the unauthenticated state.
class AuthSignedOut extends AuthEvent {
  const AuthSignedOut();
}
