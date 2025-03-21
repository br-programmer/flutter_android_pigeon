import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/pigeon/biometric/biometrics_api.g.dart';

/// Concrete implementation of [IAuthDatasource] using [IBiometricsApi].
///
/// This class bridges the Dart code with native platform APIs for authentication,
/// utilizing the Pigeon-generated [IBiometricsApi] interface. It provides methods to:
/// - Retrieve available authentication methods.
/// - Check capability of a specific method.
/// - Trigger authentication with custom UI texts.
///
/// Errors from the native layer are mapped and thrown as [BiometricAuthException].
class AuthLocalDatasource implements IAuthDatasource {
  /// Creates an instance of [AuthLocalDatasource] with the provided [IBiometricsApi].
  AuthLocalDatasource({required IBiometricsApi api}) : _api = api;

  final IBiometricsApi _api;

  @override
  Future<List<AuthMethod>> getAvailableMethods() async {
    final methodsAvailable = await _api.methodsAvailable();

    // Map platform response to internal AuthMethod enum.
    return methodsAvailable.mapList(
      (m) => switch (m.method) {
        'biometric_strong' => AuthMethod.biometricStrong,
        'biometric_weak' => AuthMethod.biometricWeak,
        'device_credential' => AuthMethod.deviceCredential,
        _ => AuthMethod.unsupported,
      },
    );
  }

  @override
  Future<bool> canAuthenticate(AuthMethod method) {
    // Check if authentication is possible for the given method.
    return _api.canAuthenticate(BiometricMethodDto(method: method.name));
  }

  @override
  Future<void> authenticate({
    required AuthMethod method,
    required String title,
    required String subtitle,
    String? cancel,
  }) async {
    final result = await _api.authenticate(
      BiometricTexts(title: title, subtitle: subtitle, cancel: cancel),
      BiometricMethodDto(method: method.name),
    );

    // If result contains a message, it indicates failure; throw an exception.
    return switch (result.message) {
      String() => throw BiometricAuthException(result.code),
      null => null,
    };
  }
}
