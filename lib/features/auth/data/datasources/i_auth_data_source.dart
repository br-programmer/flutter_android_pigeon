import 'package:qr_biometrics_app/features/auth/auth.dart';
import 'package:qr_biometrics_app/features/features.dart'
    show AuthMethod, BiometricAuthException;

/// Interface for interacting with device-level authentication mechanisms.
///
/// Defines contracts to:
/// - Retrieve available authentication methods.
/// - Check authentication capability.
/// - Trigger authentication flows with custom UI prompts.
///
/// This abstraction allows higher layers (e.g., repositories, blocs)
/// to remain independent of platform-specific implementations.
abstract interface class IAuthDatasource {
  /// Retrieves a list of available authentication methods on the device.
  ///
  /// Returns a [List] of [AuthMethod] indicating which methods
  /// (e.g., biometrics, device credentials) are supported and ready to use.
  ///
  /// Example:
  /// ```dart
  /// final methods = await datasource.getAvailableMethods();
  /// if (methods.contains(AuthMethod.biometric)) {
  ///   // Biometrics supported
  /// }
  /// ```
  Future<List<AuthMethod>> getAvailableMethods();

  /// Checks if the device can authenticate using the specified [method].
  ///
  /// Returns `true` if the [AuthMethod] is available and can be used,
  /// otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// final canAuth = await datasource.canAuthenticate(AuthMethod.deviceCredential);
  /// if (canAuth) {
  ///   // Enable device credential login
  /// }
  /// ```
  Future<bool> canAuthenticate(AuthMethod method);

  /// Triggers authentication using the specified [method].
  ///
  /// Displays a native authentication prompt with the given [title]
  /// and [subtitle]. An optional [cancel] text may be shown on the prompt.
  ///
  /// Throws an exception (e.g., [BiometricAuthException]) if authentication fails.
  /// Returns normally (`void`) if authentication succeeds.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await datasource.authenticate(
  ///     method: AuthMethod.biometric,
  ///     title: 'Sign In',
  ///     subtitle: 'Use biometrics to continue',
  ///     cancel: 'Cancel',
  ///   );
  ///   // Success
  /// } catch (e) {
  ///   // Handle failure
  /// }
  /// ```
  Future<void> authenticate({
    required AuthMethod method,
    required String title,
    required String subtitle,
    String? cancel,
  });
}
