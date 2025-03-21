part of 'auth_bloc.dart';

/// Base class for all states emitted by [AuthBloc].
///
/// Manages the global authentication status of the app, which is used
/// for session persistence and navigation redirection.
///
/// Implements [Equatable] to enable value comparison.
sealed class AuthState extends Equatable {
  /// Const constructor for [AuthState].
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before determining the user's authentication status.
///
/// This state is typically emitted at app startup while loading session data.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State emitted while processing authentication-related actions.
///
/// Useful for showing global loading indicators, e.g., during sign-out or session checks.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State emitted when the user is authenticated and has an active session.
///
/// This state allows access to authenticated areas of the app.
class Authenticated extends AuthState {
  const Authenticated();
}

/// State emitted when the user is not authenticated.
///
/// This can occur on app launch, session expiration, or after signing out.
class Unauthenticated extends AuthState {
  const Unauthenticated();
}
