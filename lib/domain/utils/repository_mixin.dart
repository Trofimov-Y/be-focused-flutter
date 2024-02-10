import 'package:be_focused/app/logger.dart';
import 'package:be_focused/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/transformers.dart';

mixin RepositoryMixin {
  TaskEither<Failure, T> wrapTaskEither<T>(
    Future<T> Function() job,
    Failure Function(Object error) onError,
  ) {
    return TaskEither.tryCatch(
      () => job(),
      (error, stackTrace) {
        logger.e(error.toString(), error: error, stackTrace: stackTrace);
        return onError(error);
      },
    );
  }

  Either<Failure, T> wrapAsEither<T>(
    T Function() job,
    Failure Function(Object error) onError,
  ) {
    return Either.tryCatch(() => job(), (error, stackTrace) {
      logger.e(error.toString(), error: error, stackTrace: stackTrace);
      return onError(error);
    });
  }

  Stream<T> wrapStream<T>(Stream<T> stream) {
    return stream.doOnData(logger.i).doOnError((error, stackTrace) {
      logger.e(error.toString(), error: error, stackTrace: stackTrace);
    });
  }
}
