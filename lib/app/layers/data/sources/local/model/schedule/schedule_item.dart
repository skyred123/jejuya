import 'package:json_annotation/json_annotation.dart';

part 'schedule_item.g.dart';

/// Destination entity.
@JsonSerializable(
  explicitToJson: true,
)
class ScheduleItem {
  /// Default constructor for the [ScheduleItem].
  ScheduleItem({
    required this.id,
    this.startTime,
    this.endTime,
  });

  /// Factory constructor for the [Destination].
  factory ScheduleItem.fromJson(Map<String, dynamic> json) =>
      _$ScheduleItemFromJson(json);

  /// Converts the [Destination] to a JSON object.
  Map<String, dynamic> toJson() => _$ScheduleItemToJson(this);

  /// Destination entity [id] property.
  String id;

  /// Destination entity [startTime] property.
  DateTime? startTime;

  /// Destination entity [endTime] property.
  DateTime? endTime;

  /// Overrides the `toString` method to provide a readable representation.
  @override
  String toString() {
    return '{id: $id, startTime: ${startTime?.toIso8601String()}, endTime: ${endTime?.toIso8601String()}}';
  }
}
