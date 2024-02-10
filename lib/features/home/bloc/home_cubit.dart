import 'dart:async';

import 'package:be_focused/domain/entities/activity.dart';
import 'package:be_focused/domain/usecases/create_activity_usecase.dart';
import 'package:be_focused/domain/usecases/get_activities_stream_usecase.dart';
import 'package:be_focused/domain/usecases/update_activity_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

@Injectable()
final class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._createActivityUseCase,
    this._getActivitiesStreamUseCase,
    this._updateActivityUseCase,
  ) : super(HomeState.initial(date: DateTime.now())) {
    _init();
  }

  final CreateActivityUseCase _createActivityUseCase;
  final UpdateActivityUseCase _updateActivityUseCase;
  final GetActivitiesStreamUseCase _getActivitiesStreamUseCase;

  late StreamSubscription<List<Activity>> _activitiesStreamSubscription;

  void _init() {
    _activitiesStreamSubscription = _getActivitiesStreamUseCase().listen(
      (activities) {
        emit(HomeState.data(activities: activities, date: state.date));
      },
    );
  }

  @override
  Future<void> close() async {
    await _activitiesStreamSubscription.cancel();
    return super.close();
  }

  void createActivity({
    required String title,
    required int color,
    required DateTime startedAt,
    String? description,
    Duration? duration,
  }) {
    _createActivityUseCase(
      Activity(
        title: title,
        description: description,
        color: color,
        startedAt: startedAt,
        duration: duration,
      ),
    ).run();
  }

  void completeActivity(Activity activity) {
    _updateActivityUseCase(activity.copyWith(completedAt: DateTime.now())).run();
  }

  void unCompleteActivity(Activity activity) {
    _updateActivityUseCase(activity.copyWith(completedAt: null)).run();
  }

  void deleteActivity(Activity activity) => _updateActivityUseCase(activity).run();

  void changeDate(DateTime date) {
    emit(state.copyWith(date: date.toLocal()));
  }
}
