import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/core/fp/fp.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';

/// Base class representing failures related to session management.
///
/// Used in [Result] types to model errors when saving, reading,
/// or clearing the session state, allowing structured error handling.
sealed class SessionFailure {
  const SessionFailure();
}

/// Failure when persisting the session state fails.
///
/// Typically caused by platform errors or storage issues
/// during the save operation.
class SaveSessionFailure extends SessionFailure {
  const SaveSessionFailure();
}

/// Failure when retrieving the session state fails.
///
/// Occurs when secure storage cannot be read or is inaccessible.
class ReadSessionFailure extends SessionFailure {
  const ReadSessionFailure();
}

/// Failure when attempting to clear the session state fails.
///
/// Can be triggered by issues with secure storage during deletion.
class ClearSessionFailure extends SessionFailure {
  const ClearSessionFailure();
}

/// Fallback failure for unknown or unexpected errors.
///
/// Used when the specific cause of failure is not identifiable.
class UnknownSessionFailure extends SessionFailure {
  const UnknownSessionFailure();
}
