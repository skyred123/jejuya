class Location {
  final String name;
  final String address;
  final String time;

  Location({
    required this.name,
    required this.address,
    required this.time,
  });

  // Factory constructor để khởi tạo từ JSON Map
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      address: json['address'],
      time: json['time'],
    );
  }
}

class Schedule {
  final String date;
  final List<Location> locations;

  Schedule({
    required this.date,
    required this.locations,
  });

  // Factory constructor để khởi tạo từ JSON Map
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      date: json['date'],
      locations: List<Location>.from(json['locations'].map((location) {
        return Location.fromJson(location);
      })),
    );
  }

  // Phương thức tĩnh để tạo danh sách Schedule từ JSON
  static List<Schedule> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Schedule.fromJson(json)).toList();
  }
}
