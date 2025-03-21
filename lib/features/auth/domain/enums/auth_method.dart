/// Enum representing available authentication methods.
///
/// Used to identify and handle the type of authentication supported
/// or selected by the user or device. Each value is associated with a
/// string [name], which can be used for serialization or native API communication.
enum AuthMethod {
  /// Strong biometric authentication (e.g., high-security fingerprint, face recognition).
  ///
  /// Indicates that the biometric method meets higher security standards.
  /// Typically required for sensitive operations like payments or unlocking devices.
  biometricStrong('biometric_strong'),

  /// Weak biometric authentication (e.g., basic face unlock, low-security fingerprint).
  ///
  /// Indicates that the biometric method provides lower assurance and may not meet
  /// high-security standards, but can still be used for less critical operations.
  biometricWeak('biometric_weak'),

  /// Device credential authentication (e.g., PIN, password, pattern).
  ///
  /// Uses the device's secure lock screen credentials for authentication.
  deviceCredential('device_credential'),

  /// Indicates that no supported authentication method is available.
  ///
  /// Typically used as a fallback when the device lacks hardware or permissions.
  unsupported('unsupported');

  /// Creates an [AuthMethod] with its corresponding string [name].
  const AuthMethod(this.name);

  /// String identifier for the authentication method.
  ///
  /// Useful for serialization, logging, or platform communication.
  final String name;
}
