/// A sealed class representing a result that can either be a success or a failure.
///
/// - `T`: The type of the data in case of success.
/// - `E`: The type of the error in case of failure.
sealed class Result<T, E> {}

/// A class representing a successful result, containing the data of type `T`.
///
/// - `T`: The type of the data returned in the success case.
class Success<T, E> extends Result<T, E> {
  Success(this.data);
  final T data;
}

/// A class representing a failure result, containing the error of type `E`.
///
/// - `E`: The type of the error returned in the failure case.
class Failure<T, E> extends Result<T, E> {
  Failure(this.error);
  final E error;
}

/// A type alias representing a `Future` that returns a `Result` of type `T` for data
/// and type `E` for error.
typedef FutureResult<T, E> = Future<Result<T, E>>;

/// A type alias representing a `Result` that doesn't return any data, but contains an error of type `E`.
typedef VoidResult<E> = Result<void, E>;

/// A type alias representing a `Future` that returns a `Result` with no data (void) and an error of type `E`.
typedef FutureVoidResult<E> = Future<Result<void, E>>;
