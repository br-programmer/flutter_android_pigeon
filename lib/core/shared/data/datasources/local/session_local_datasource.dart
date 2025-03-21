import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/pigeon/session/session_api.g.dart';

/// A local datasource implementation for managing session-related data.
///
/// This class implements the `ISessionDatasource` interface and provides methods
/// to interact with session data locally. It relies on an `ISessionApi` instance
/// to handle the actual communication with the session API.
///
/// - `sessionActive`: Checks if a session is active by calling the `getSession` method
///   from the `ISessionApi`.
/// - `saveSession`: Saves the session data (authenticated status) by calling the
///   `saveSession` method from the `ISessionApi`.
/// - `clearSession`: Clears the session data by calling the `clearSession` method
///   from the `ISessionApi`.
class SessionLocalDatasource implements ISessionDatasource {
  SessionLocalDatasource({required ISessionApi api}) : _api = api;

  final ISessionApi _api;

  /// Checks if the session is active.
  ///
  /// Calls the `getSession` method from the `ISessionApi` to retrieve the session status.
  ///
  /// Returns `true` if the session is active, `false` if it is not, or `null` if
  /// the session status is unknown.
  @override
  Future<bool?> sessionActive() {
    return _api.getSession();
  }

  /// Saves the session data.
  ///
  /// Accepts a boolean value indicating whether the user is authenticated (`true`)
  /// or not (`false`), and stores this status using the `saveSession` method
  /// from the `ISessionApi`.
  @override
  Future<void> saveSession(bool authenticated) {
    return _api.saveSession(authenticated);
  }

  /// Clears the session data.
  ///
  /// Calls the `clearSession` method from the `ISessionApi` to clear any stored session data.
  @override
  Future<void> clearSession() {
    return _api.clearSession();
  }
}
