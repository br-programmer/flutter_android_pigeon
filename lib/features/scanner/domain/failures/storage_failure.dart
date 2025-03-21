/// A base class for all storage-related failures.
///
/// This class serves as the parent for all failure types that may occur during
/// storage operations (e.g., reading or writing data). It allows for structured
/// handling of errors related to storage operations.
sealed class StorageFailure {
  const StorageFailure();
}

/// Represents a failure when writing data to storage.
///
/// This class is used when an error occurs during the write operation, such as
/// issues with saving data to the storage (e.g., file system or database).
class StorageWriteFailure extends StorageFailure {
  const StorageWriteFailure();
}

/// Represents a failure when reading data from storage.
///
/// This class is used when an error occurs during the read operation, such as
/// issues with retrieving data from storage.
class StorageReadFailure extends StorageFailure {
  const StorageReadFailure();
}

/// Represents an unknown or unexpected failure during storage operations.
///
/// This class is used when an unexpected error occurs, and it holds the original
/// error object for further inspection or debugging.
///
/// - `error`: The error that caused the failure, which can be any type of object.
class UnknownStorageFailure extends StorageFailure {
  const UnknownStorageFailure({required this.error});
  final Object error;
}
