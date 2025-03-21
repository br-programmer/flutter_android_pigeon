import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_biometrics_app/core/core.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// The `AuthBloc` manages the global authentication state of the application.
///
/// It handles authentication events such as session verification, sign-in,
/// and sign-out actions, and emits the corresponding [AuthState] changes
/// to control user access and navigation. This bloc ensures that the
/// application responds appropriately to authentication-related events.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructs the [AuthBloc] with an initial [AuthState] and registers
  /// event handlers for session management actions.
  ///
  /// - `sessionRepository`: The repository used to manage the session.
  /// - `delay`: Optional delay before performing actions like checking session state.
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

  /// The delay before performing session-related actions.
  final Duration delay;

  /// Handles the [AuthCheckRequested] event.
  ///
  /// This event checks whether the session is active by calling
  /// `sessionActive()` from the [ISessionRepository]. It emits either
  /// [Authenticated] or [Unauthenticated] based on the result.
  ///
  /// - Emits [AuthLoading] while checking the session.
  /// - Emits [Authenticated] if the session is active.
  /// - Emits [Unauthenticated] if the session is not active or there is a failure.
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
  /// This event persists the session by calling `saveSession()` on the
  /// [ISessionRepository] and emits [Authenticated] if successful.
  /// If the session cannot be saved, it emits [Unauthenticated].
  ///
  /// - Emits [Authenticated] if session saving is successful.
  /// - Emits [Unauthenticated] if saving the session fails.
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
  /// This event clears the session and ensures that the application
  /// always emits [Unauthenticated], regardless of the result of the session
  /// clearing, to enforce the logout action.
  Future<void> _onAuthSignedOut(
    AuthSignedOut event,
    Emitter<AuthState> emit,
  ) async {
    await _sessionRepository.clearSession();
    emit(const Unauthenticated());
  }
}
