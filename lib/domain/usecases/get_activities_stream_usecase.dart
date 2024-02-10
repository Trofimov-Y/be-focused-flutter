import 'package:be_focused/domain/entities/activity.dart';
import 'package:be_focused/domain/repositories/activities_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class GetActivitiesStreamUseCase {
  const GetActivitiesStreamUseCase(this._activitiesRepository);

  final ActivitiesRepository _activitiesRepository;

  Stream<List<Activity>> call() => _activitiesRepository.getActivitiesStream();
}
