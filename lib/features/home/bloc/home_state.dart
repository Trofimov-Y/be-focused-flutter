part of 'home_cubit.dart';

@freezed
sealed class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState.initial({
    required DateTime date,
  }) = Initial;

  const factory HomeState.data({
    required DateTime date,
    required List<Activity> activities,
  }) = Data;

  const factory HomeState.error({
    required DateTime date,
  }) = Error;

  List<Activity> get completedActivities => maybeMap(
        data: (state) => state.activities
            .where(
              (activity) =>
                  activity.completedAt != null && activity.startedAt.date == state.date.date,
            )
            .sortedBy((activity) => activity.completedAt!),
        orElse: () => [],
      );

  List<Activity> get plannedActivities => maybeMap(
        data: (state) => state.activities
            .where(
              (activity) =>
                  activity.duration != null &&
                  activity.completedAt == null &&
                  activity.startedAt.date == state.date.date,
            )
            .sortedBy((activity) => activity.startedAt),
        orElse: () => [],
      );

  List<Activity> get dailyActivities => maybeMap(
        data: (state) => state.activities
            .where(
              (activity) =>
                  activity.duration == null &&
                  activity.completedAt == null &&
                  activity.startedAt.date == state.date.date,
            )
            .sortedBy((activity) => activity.title),
        orElse: () => [],
      );
}
