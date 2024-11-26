import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Hotel {
  Hotel({
    required this.id,
    required this.businessNameEnglish,
    required this.businessNameKorean,
    required this.latitude,
    required this.longitude,
    required this.contact,
    required this.noteEnglish,
    required this.noteKorean,
    required this.roadNameAdressEnglish,
    required this.roadNameAdressKorean,
    required this.numberOfRooms,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelToJson(this);

  String id;

  String businessNameEnglish;

  String businessNameKorean;

  String latitude;

  String longitude;

  String contact;

  String noteEnglish;

  String noteKorean;

  String roadNameAdressEnglish;

  String roadNameAdressKorean;

  String numberOfRooms;
}
