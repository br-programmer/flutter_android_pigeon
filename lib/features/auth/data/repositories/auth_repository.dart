import 'package:flutter/services.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// Repository implementation for handling authentication logic.
///
/// Implements [IAuthRepository] by delegating authentication-related
/// operations to a data source ([IAuthDatasource]).
///
/// All methods return [Result]-wrapped values to enable structured,
/// exception-free error handling via [AuthFailure] types.
class AuthRepository implements IAuthRepository {
  /// Creates an [AuthRepository] with the provided [IAuthDatasource].
  AuthRepository({required IAuthDatasource dataSource})
      : _dataSource = dataSource;

  final IAuthDatasource _dataSource;

  @override
  FutureResult<List<AuthMethod>, AuthFailure> getAvailableMethods() async {
    try {
      final methods = await _dataSource.getAvailableMethods();
      return Success(methods);
    } on PlatformException catch (e) {
      // Platform-specific error (e.g., native communication failure).
      return Failure(PlatformAuthFailure(error: e));
    } on Exception catch (e) {
      // Fallback for any other unexpected error.
      return Failure(UnknownAuthFailure(error: e));
    }
  }

  @override
  FutureResult<bool, AuthFailure> canAuthenticate(AuthMethod method) async {
    try {
      final canAuth = await _dataSource.canAuthenticate(method);
      return Success(canAuth);
    } on PlatformException catch (e) {
      return Failure(PlatformAuthFailure(error: e));
    } on Exception catch (e) {
      return Failure(UnknownAuthFailure(error: e));
    }
  }

  @override
  FutureVoidResult<AuthFailure> authenticate({
    required String title,
    required String subtitle,
    String? cancel,
    required AuthMethod method,
  }) async {
    try {
      await _dataSource.authenticate(
        method: method,
        title: title,
        subtitle: subtitle,
        cancel: cancel,
      );
      return Success(null);
    } on BiometricAuthException catch (e) {
      // Known biometric-specific failure from platform.
      return Failure(AuthFailure.fromCode(e.code));
    } on PlatformException catch (e) {
      return Failure(PlatformAuthFailure(error: e));
    } on Exception catch (e) {
      return Failure(UnknownAuthFailure(error: e));
    }
  }
}
