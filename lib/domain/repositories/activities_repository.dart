import 'package:be_focused/domain/entities/activity.dart';
import 'package:be_focused/domain/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ActivitiesRepository {
  TaskEither<Failure, void> create(Activity entity);

  TaskEither<Failure, void> delete(String id);

  TaskEither<Failure, void> update(Activity entity);

  Stream<List<Activity>> getActivitiesStream();
}
