import 'package:be_focused/app/extensions/object_extensions.dart';
import 'package:be_focused/data/models/activity_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';

@Freezed()
class Activity with _$Activity {
  const factory Activity({
    required String title,
    required int color,
    required DateTime startedAt,
    required Duration? duration,
    required String? description,
    String? id,
    DateTime? completedAt,
  }) = _Activity;

  factory Activity.fromModel(ActivityModel model) => Activity(
        id: model.id,
        title: model.title,
        description: model.description,
        color: model.color,
        startedAt: model.startedAt,
        completedAt: model.completedAt,
        duration: model.durationInSeconds?.let((duration) => Duration(seconds: duration)),
      );
}
