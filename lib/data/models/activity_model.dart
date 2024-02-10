import 'package:be_focused/domain/entities/activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
final class ActivityModel {
  const ActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.startedAt,
    required this.completedAt,
    required this.durationInSeconds,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  factory ActivityModel.fromEntity(Activity entity) => ActivityModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        color: entity.color,
        startedAt: entity.startedAt,
        completedAt: entity.completedAt,
        durationInSeconds: entity.duration?.inSeconds,
      );

  final String? id;
  final String title;
  final String? description;
  final int color;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int? durationInSeconds;

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
