import 'package:flutter/services.dart';
import 'package:qr_biometrics_app/core/core.dart';

/// Concrete implementation of [ISessionRepository].
///
/// Delegates session persistence operations to a platform-backed
/// [ISessionDatasource] and wraps all results in a functional [Result]
/// to enable structured, exception-free error handling.
class SessionRepository implements ISessionRepository {
  /// Creates a [SessionRepository] with the given [ISessionDatasource].
  SessionRepository({required ISessionDatasource dataSource})
      : _dataSource = dataSource;

  final ISessionDatasource _dataSource;

  @override
  FutureResult<bool, SessionFailure> sessionActive() async {
    try {
      final active = await _dataSource.sessionActive();
      return Success(active ?? false);
    } on PlatformException catch (_) {
      // Failure from native platform (e.g., Pigeon/Channel error).
      return Failure(const ReadSessionFailure());
    } on Exception catch (_) {
      // Unknown or unexpected error.
      return Failure(const UnknownSessionFailure());
    }
  }

  @override
  FutureVoidResult<SessionFailure> saveSession(bool authenticated) async {
    try {
      await _dataSource.saveSession(authenticated);
      return Success(null);
    } on PlatformException catch (_) {
      return Failure(const SaveSessionFailure());
    } on Exception catch (_) {
      return Failure(const UnknownSessionFailure());
    }
  }

  @override
  FutureVoidResult<SessionFailure> clearSession() async {
    try {
      await _dataSource.clearSession();
      return Success(null);
    } on PlatformException catch (_) {
      return Failure(const ClearSessionFailure());
    } on Exception catch (_) {
      return Failure(const UnknownSessionFailure());
    }
  }
}
