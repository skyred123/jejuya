import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

/// Destination entity.
@JsonSerializable(
  explicitToJson: true,
)
class Schedule {
  /// Default constructor for the [Schedule].
  Schedule({
    required this.id,
    this.startTime,
    this.endTime,
  });

  /// Factory constructor for the [Destination].
  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  /// Converts the [Destination] to a JSON object.
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  /// Destination entity [id] property.
  String id;

  /// Destination entity [startTime] property.
  DateTime? startTime;

  /// Destination entity [endTime] property.
  DateTime? endTime;
}
