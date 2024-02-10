import 'package:be_focused/data/data_sources/activities_remote_datasource.dart';
import 'package:be_focused/data/models/activity_model.dart';
import 'package:be_focused/domain/entities/activity.dart';
import 'package:be_focused/domain/errors/failure.dart';
import 'package:be_focused/domain/repositories/activities_repository.dart';
import 'package:be_focused/domain/utils/repository_mixin.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ActivitiesRepository)
final class ActivitiesRepositoryImpl with RepositoryMixin implements ActivitiesRepository {
  const ActivitiesRepositoryImpl(this._activitiesRemoteDataSource);

  final ActivitiesRemoteDataSource _activitiesRemoteDataSource;

  @override
  TaskEither<Failure, void> create(Activity entity) => wrapTaskEither(
        () => _activitiesRemoteDataSource.create(ActivityModel.fromEntity(entity)),
        (error) => GeneralFailure(),
      );

  @override
  Stream<List<Activity>> getActivitiesStream() => wrapStream(
        _activitiesRemoteDataSource.getActivitiesStream().map(
              (models) => models.map(Activity.fromModel).toList(),
            ),
      );

  @override
  TaskEither<Failure, void> delete(String id) =>
      wrapTaskEither(() => _activitiesRemoteDataSource.delete(id), (error) => GeneralFailure());

  @override
  TaskEither<Failure, void> update(Activity entity) => wrapTaskEither(
        () => _activitiesRemoteDataSource.update(ActivityModel.fromEntity(entity)),
        (error) => GeneralFailure(),
      );
}
