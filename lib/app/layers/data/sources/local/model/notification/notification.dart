import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

/// Notification entity.
@JsonSerializable(
  explicitToJson: true,
  // fieldRename: FieldRename.snake,
)
class Notification {
  /// Default constructor for the [Notification].
  Notification({
    required this.id,
    required this.userId,
    this.title,
    this.body,
  });

  /// Factory constructor for the [User].
  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  /// Converts the [User] to a JSON object.
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  /// Notification entity [id] properties
  num id;

  /// Notification entity [id] properties
  num userId;

  /// Notification entity [title] properties
  String? title;

  /// Notification entity [body] properties
  String? body;
}
