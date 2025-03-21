import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/pigeon/session/session_api.g.dart';

class SessionLocalDatasource implements ISessionDatasource {
  SessionLocalDatasource({required ISessionApi api}) : _api = api;

  final ISessionApi _api;

  @override
  Future<bool?> sessionActive() {
    return _api.getSession();
  }

  @override
  Future<void> saveSession(bool authenticated) {
    return _api.saveSession(authenticated);
  }

  @override
  Future<void> clearSession() {
    return _api.clearSession();
  }
}
