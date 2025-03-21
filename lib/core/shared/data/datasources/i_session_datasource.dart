/// Interface for managing the user session state.
///
/// Defines methods to persist, retrieve, and clear a session flag,
/// typically stored securely via native code (e.g., EncryptedSharedPreferences on Android).
abstract interface class ISessionDatasource {
  /// Retrieves the current session status.
  ///
  /// Returns `true` if a session is active (i.e., previously saved as `true`),
  /// or `false` if the session is inactive, not set, or an error occurs.
  ///
  /// This method never throws and defaults to `false` for missing or invalid data.
  Future<bool?> sessionActive();

  /// Clears the persisted session flag.
  ///
  /// Typically called during logout or when the session is invalidated.
  Future<void> clearSession();

  /// Persists the session status securely.
  ///
  /// Stores [authenticated] in secure storage to indicate whether the user
  /// has an active authenticated session (e.g., biometric login completed).
  ///
  /// [authenticated] — `true` if the user has successfully authenticated.
  Future<void> saveSession(bool authenticated);
}
