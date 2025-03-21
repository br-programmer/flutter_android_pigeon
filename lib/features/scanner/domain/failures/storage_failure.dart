sealed class StorageFailure {
  const StorageFailure();
}

class StorageWriteFailure extends StorageFailure {
  const StorageWriteFailure();
}

class StorageReadFailure extends StorageFailure {
  const StorageReadFailure();
}

class UnknownStorageFailure extends StorageFailure {
  const UnknownStorageFailure({required this.error});
  final Object error;
}
