import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule.dart';

class UserDetail {
  String? id;

  List<Schedule>? schedules; // <Schedule>

  List<Schedule>? favoriteSchedule;

  /// Default constructor for the [UserDetail].
  UserDetail({
    required this.id,
    this.schedules,
    this.favoriteSchedule,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    // Khởi tạo danh sách từ JSON
    List<Schedule>? schedules = [];
    if (json['ListSchedule'] != null) {
      schedules = (json['ListSchedule'] as List)
          .map((v) => Schedule.fromJson(v))
          .toList();
    }

    List<Schedule>? favoriteSchedule = [];
    if (json['FavoriteSchedule'] != null) {
      favoriteSchedule = (json['FavoriteSchedule'] as List)
          .map((v) => Schedule.fromJson(v))
          .toList();
    }

    // Trả về UserDetail với các danh sách đã xử lý
    return UserDetail(
      id: json['id'] ?? "", // Đảm bảo không null
      schedules: schedules,
      favoriteSchedule: favoriteSchedule,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    if (schedules != null) {
      data['Schedules'] = schedules!.map((v) => v.toJson()).toList();
    }
    if (favoriteSchedule != null) {
      data['FavoriteSchedule'] =
          favoriteSchedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
