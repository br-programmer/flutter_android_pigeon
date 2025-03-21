sealed class Result<T, E> {}

class Success<T, E> extends Result<T, E> {
  Success(this.data);
  final T data;
}

class Failure<T, E> extends Result<T, E> {
  Failure(this.error);
  final E error;
}

typedef FutureResult<T, E> = Future<Result<T, E>>;
typedef VoidResult<E> = Result<void, E>;
typedef FutureVoidResult<E> = Future<Result<void, E>>;
