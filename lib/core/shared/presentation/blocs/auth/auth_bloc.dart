import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_biometrics_app/core/core.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// [AuthBloc] manages the global authentication state of the application.
///
/// It handles session verification, sign-in, and sign-out actions,
/// emitting corresponding [AuthState] changes to control access and navigation.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructs [AuthBloc] with an initial [AuthState],
  /// and registers event handlers for session management.
  AuthBloc(
    super.initialState, {
    required ISessionRepository sessionRepository,
    this.delay = Duration.zero,
  }) : _sessionRepository = sessionRepository {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignedIn>(_onAuthSignedIn);
    on<AuthSignedOut>(_onAuthSignedOut);
  }

  final ISessionRepository _sessionRepository;

  final Duration delay;

  /// Handles the [AuthCheckRequested] event.
  ///
  /// Checks if a session is active via [ISessionRepository] and
  /// emits [Authenticated] or [Unauthenticated] accordingly.
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future<void>.delayed(delay);
    final result = await _sessionRepository.sessionActive();
    final state = switch (result) {
      Success(:final data) when data => const Authenticated(),
      Success() => const Unauthenticated(),
      Failure() => const Unauthenticated(),
    };
    emit(state);
  }

  /// Handles the [AuthSignedIn] event.
  ///
  /// Persists the session and emits [Authenticated] on success,
  /// otherwise emits [Unauthenticated].
  Future<void> _onAuthSignedIn(
    AuthSignedIn event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _sessionRepository.saveSession(true);
    final state = switch (result) {
      Success() => const Authenticated(),
      Failure() => const Unauthenticated(),
    };
    emit(state);
  }

  /// Handles the [AuthSignedOut] event.
  ///
  /// Clears the session and always emits [Unauthenticated],
  /// regardless of the result, to enforce logout.
  Future<void> _onAuthSignedOut(
    AuthSignedOut event,
    Emitter<AuthState> emit,
  ) async {
    await _sessionRepository.clearSession();
    emit(const Unauthenticated());
  }
}
