import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart'
    show AuthFailure, AuthMethod;

/// Repository interface for authentication logic at the domain level.
///
/// Provides methods to:
/// - Retrieve supported authentication methods.
/// - Check if authentication is possible with a given method.
/// - Trigger authentication using customizable UI prompts.
///
/// All methods return results wrapped in [Result] types, enabling
/// structured, exception-free error handling via [AuthFailure].
abstract interface class IAuthRepository {
  /// Retrieves the list of authentication methods supported by the device.
  ///
  /// Returns a [FutureResult] containing:
  /// - `Success(List<AuthMethod>)` if retrieval succeeds.
  /// - `Failure(AuthFailure)` if retrieval fails (e.g., permission denied, hardware unavailable).
  ///
  /// Example:
  /// ```dart
  /// final result = await authRepository.getAvailableMethods();
  /// switch (result) {
  ///   case Success(:final methods):
  ///     // Use available methods
  ///   case Failure(:final error):
  ///     // Handle failure
  /// }
  /// ```
  FutureResult<List<AuthMethod>, AuthFailure> getAvailableMethods();

  /// Checks if the device can authenticate using the specified [method].
  ///
  /// Returns a [FutureResult] containing:
  /// - `Success(true)` if authentication is possible.
  /// - `Success(false)` if authentication is not possible.
  /// - `Failure(AuthFailure)` if an error occurs during the check.
  ///
  /// Example:
  /// ```dart
  /// final result = await authRepository.canAuthenticate(AuthMethod.biometric);
  /// switch (result) {
  ///   case Success(:final canAuth) when canAuth:
  ///     // Proceed with biometric auth
  ///   case Success():
  ///     // Auth method unavailable
  ///   case Failure(:final error):
  ///     // Handle failure
  /// }
  /// ```
  FutureResult<bool, AuthFailure> canAuthenticate(AuthMethod method);

  /// Initiates authentication using the specified [method].
  ///
  /// Displays a native prompt with [title] and [subtitle].
  /// Optionally displays a [cancel] button.
  ///
  /// Returns a [FutureVoidResult] containing:
  /// - `Success(null)` if authentication succeeds.
  /// - `Failure(AuthFailure)` if authentication fails.
  ///
  /// Example:
  /// ```dart
  /// final result = await authRepository.authenticate(
  ///   title: 'Sign In',
  ///   subtitle: 'Use biometrics to continue',
  ///   method: AuthMethod.biometric,
  /// );
  /// switch (result) {
  ///   case Success():
  ///     // Authenticated successfully
  ///   case Failure(:final error):
  ///     // Handle AuthFailure
  /// }
  /// ```
  FutureVoidResult<AuthFailure> authenticate({
    required String title,
    required String subtitle,
    String? cancel,
    required AuthMethod method,
  });
}
