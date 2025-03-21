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

  factory AuthFailure.fromCode(String code) {
    return switch (code) {
      'unavailable' => const BiometricUnavailable(),
      'failed' => const AuthenticationFailed(),
      'error' => const AuthenticationError(),
      'cancelled' => const AuthenticationCancelled(),
      _ => UnknownAuthFailure(error: code),
    };
  }

  /// Creates an [AuthFailure] based on a provided string [code].
  ///
  /// Maps known error codes to their corresponding failure types:
  /// - `'unavailable'` → [BiometricUnavailable]
  /// - `'failed'` → [AuthenticationFailed]
  /// - `'error'` → [AuthenticationError]
  /// - Any other code → [UnknownAuthFailure]
  ///
  /// Example:
  /// ```dart
  /// final failure = AuthFailure.fromCode('failed');
  /// if (failure is AuthenticationFailed) {
  ///   // Handle the failure appropriately.
  /// }
  /// ```
  ///
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

class PlatformAuthFailure extends AuthFailure {
  const PlatformAuthFailure({required this.error});

  final Object error;

  @override
  String get code => 'platform_error';
}

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

extension AuthFailureX on AuthFailure {
  bool get cancelled => this is AuthenticationCancelled;
}
