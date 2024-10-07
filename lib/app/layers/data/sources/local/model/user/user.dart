import 'dart:convert';

import 'package:jejuya/core/reactive/obs_setting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User entity.
@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class User {
  /// Default constructor for the [User].
  User({
    this.username,
    required this.token,
  });

  /// Factory constructor for the [User].
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts the [User] to a JSON object.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// User username.
  String? username;

  /// User EVM address.
  String token;
}

/// User value converter.
class UserSupportedConverter extends SettingValueConverter<User, String> {
  /// Default constructor for the [UserSupportedConverter].
  const UserSupportedConverter();

  @override
  User? fromStorableValue(String? storableValue) {
    if (storableValue == null) {
      return null;
    }
    return User.fromJson(jsonDecode(storableValue) as Map<String, dynamic>);
  }

  @override
  String? toStorableValue(User? dynamicValue) {
    if (dynamicValue == null) {
      return null;
    }
    return jsonEncode(dynamicValue.toJson());
  }
}
