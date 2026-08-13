import '../error/exceptions.dart';

/// Represents the result of an API call, which can be either
/// a successful response or a failure.
sealed class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T data) = Success<T>;

  factory ApiResult.failure(ApiException error) = Failure<T>;

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  T? get dataOrNull {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    return null;
  }

  ApiException? get errorOrNull {
    if (this is Failure<T>) {
      return (this as Failure<T>).error;
    }
    return null;
  }

  R when<R>({
    required R Function(T data) success,
    required R Function(ApiException error) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else {
      return failure((this as Failure<T>).error);
    }
  }
}

final class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);
}

final class Failure<T> extends ApiResult<T> {
  final ApiException error;

  const Failure(this.error);
}
