import 'package:json_annotation/json_annotation.dart';

part 'destination.g.dart';

/// Destination entity.
@JsonSerializable(
  explicitToJson: true,
)
class Destination {
  /// Default constructor for the [Destination].
  Destination({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.businessNameEnglish,
    required this.businessNameKorean,
    this.startTime,
    this.endTime,
  });

  /// Factory constructor for the [Destination].
  factory Destination.fromJson(Map<String, dynamic> json) =>
      _$DestinationFromJson(json);

  /// Converts the [Destination] to a JSON object.
  Map<String, dynamic> toJson() => _$DestinationToJson(this);

  /// Destination entity [id] property.
  String id;

  /// Destination entity [latitude] property.
  String latitude;

  /// Destination entity [longitude] property.
  String longitude;

  /// Destination entity [businessNameEnglish] property.
  String businessNameEnglish;

  /// Destination entity [businessNameKorean] property.
  String businessNameKorean;

  /// Destination entity [startTime] property.
  DateTime? startTime;

  /// Destination entity [endTime] property.
  DateTime? endTime;
}
