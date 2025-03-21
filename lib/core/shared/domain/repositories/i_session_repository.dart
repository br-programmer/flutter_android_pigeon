import 'package:qr_biometrics_app/core/core.dart';

/// Repository interface for managing the user session at the domain level.
///
/// Provides methods to persist, retrieve, and clear the session flag
/// using a functional result type for structured error handling.
///
/// Session data is typically stored securely via platform-specific code.
abstract interface class ISessionRepository {
  /// Saves the session status securely.
  ///
  /// Persists [authenticated] to indicate whether the user has
  /// an active session (e.g., post-biometric authentication).
  ///
  /// Returns a [FutureVoidResult] containing:
  /// - `Success(null)` if the session was saved successfully.
  /// - `Failure(SessionFailure)` if an error occurred during the save operation.
  FutureVoidResult<SessionFailure> saveSession(bool authenticated);

  /// Retrieves the current session status.
  ///
  /// Returns a [FutureResult] containing:
  /// - `Success(true)` if the session is active.
  /// - `Success(false)` if the session is inactive or not set.
  /// - `Failure(SessionFailure)` if an error occurred during retrieval.
  FutureResult<bool, SessionFailure> sessionActive();

  /// Clears the stored session status.
  ///
  /// Typically invoked during logout or session expiration.
  ///
  /// Returns a [FutureVoidResult] containing:
  /// - `Success(null)` if the session was cleared successfully.
  /// - `Failure(SessionFailure)` if an error occurred during the clear operation.
  FutureVoidResult<SessionFailure> clearSession();
}
