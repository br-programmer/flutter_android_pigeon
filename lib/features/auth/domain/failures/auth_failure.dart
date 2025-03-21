import 'package:qr_biometrics_app/core/fp/result.dart';

/// Base class representing authentication-related failures.
///
/// This sealed class defines all possible failure types for the
/// authentication domain (e.g., biometric login). It is used as the
/// error type in [Result], enabling structured and explicit handling
/// of failure cases without throwing exceptions.
///
/// Use [AuthFailure.fromCode] to map platform-specific or API error
/// codes to corresponding failure instances.
sealed class AuthFailure {
  const AuthFailure();

  /// Factory method to create an instance of [AuthFailure] based on a provided [code].
  ///
  /// Maps known error codes to their corresponding failure types:
  /// - `'unavailable'` → [BiometricUnavailable]
  /// - `'failed'` → [AuthenticationFailed]
  /// - `'error'` → [AuthenticationError]
  /// - `'cancelled'` → [AuthenticationCancelled]
  /// - Any other code → [UnknownAuthFailure]
  ///
  /// Example:
  /// ```dart
  /// final failure = AuthFailure.fromCode('failed');
  /// if (failure is AuthenticationFailed) {
  ///   // Handle the failure appropriately.
  /// }
  /// ```
  factory AuthFailure.fromCode(String code) {
    return switch (code) {
      'unavailable' => const BiometricUnavailable(),
      'failed' => const AuthenticationFailed(),
      'error' => const AuthenticationError(),
      'cancelled' => const AuthenticationCancelled(),
      _ => UnknownAuthFailure(error: code),
    };
  }

  /// The error code associated with this authentication failure.
  String get code;
}

/// Indicates that biometric authentication is unavailable on the device.
///
/// Possible causes:
/// - No biometric hardware present.
/// - Biometric hardware is temporarily disabled.
/// - Biometric permissions are not granted.
class BiometricUnavailable extends AuthFailure {
  const BiometricUnavailable();

  @override
  String get code => 'unavailable';
}

/// Indicates that the biometric authentication attempt failed.
///
/// Possible causes:
/// - The user canceled the biometric prompt.
/// - The biometric input (e.g., fingerprint/face) was invalid.
/// - The biometric system failed to verify the user.
class AuthenticationFailed extends AuthFailure {
  const AuthenticationFailed();
  @override
  String get code => 'failed';
}

/// Represents a generic or unexpected authentication error.
///
/// This is used for authentication-related issues not covered by
/// [BiometricUnavailable] or [AuthenticationFailed], such as:
/// - Internal errors in the authentication SDK.
/// - Misconfiguration or unknown issues during authentication.
class AuthenticationError extends AuthFailure {
  const AuthenticationError();

  @override
  String get code => 'error';
}

/// Represents a platform-specific authentication failure.
///
/// This failure type holds the underlying error object that caused
/// the failure, typically used for platform-specific issues.
class PlatformAuthFailure extends AuthFailure {
  const PlatformAuthFailure({required this.error});

  final Object error;

  @override
  String get code => 'platform_error';
}

/// Indicates that the authentication attempt was cancelled.
///
/// This failure occurs when the user manually cancels the authentication
/// process (e.g., closing the biometric prompt).
class AuthenticationCancelled extends AuthFailure {
  const AuthenticationCancelled();

  @override
  String get code => 'cancelled';
}

/// Represents an unknown or unrecognized authentication failure.
///
/// This serves as a fallback when the provided error code is not
/// mapped explicitly in [AuthFailure.fromCode].
class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure({required this.error});

  final Object error;

  @override
  String get code => error.toString();
}

/// Extension providing helper methods for [AuthFailure] instances.
extension AuthFailureX on AuthFailure {
  /// Checks if the failure is a cancellation failure.
  ///
  /// This method returns `true` if the failure is of type [AuthenticationCancelled],
  /// indicating that the user canceled the authentication process.
  bool get cancelled => this is AuthenticationCancelled;
}
