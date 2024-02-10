import 'package:be_focused/domain/errors/failure.dart';
import 'package:be_focused/domain/repositories/activities_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class DeleteActivityUseCase {
  const DeleteActivityUseCase(this._activitiesRepository);

  final ActivitiesRepository _activitiesRepository;

  TaskEither<Failure, void> call(String id) => _activitiesRepository.delete(id);
}
