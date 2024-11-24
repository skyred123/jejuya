import 'package:json_annotation/json_annotation.dart';

part 'destination_detail.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DestinationDetail {
  DestinationDetail({
    required this.id,
    required this.turn,
    required this.categoryEnglish,
    required this.categoryKorean,
    required this.detailedCategoryEnglish,
    required this.detailedCategoryKorean,
    required this.introductionEnglish,
    required this.introductionKorean,
    required this.businessNameEnglish,
    required this.businessNameKorean,
    required this.locationEnglish,
    required this.locationKorean,
    required this.latitude,
    required this.longitude,
    required this.contact,
    required this.operatingHoursEnglish,
    required this.operatingHoursKorean,
    required this.closedDaysEnglish,
    required this.closedDaysKorean,
    required this.noteEnglish,
    required this.noteKorean,
    required this.reservationLink,
  });

  factory DestinationDetail.fromJson(Map<String, dynamic> json) =>
      _$DestinationDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationDetailToJson(this);

  String id;
  String turn;
  String categoryEnglish;
  String categoryKorean;
  String detailedCategoryEnglish;
  String detailedCategoryKorean;
  String introductionEnglish;
  String introductionKorean;
  String businessNameEnglish;
  String businessNameKorean;
  String locationEnglish;
  String locationKorean;
  String latitude;
  String longitude;
  String contact;
  String operatingHoursEnglish;
  String operatingHoursKorean;
  String closedDaysEnglish;
  String closedDaysKorean;
  String noteEnglish;
  String noteKorean;
  String reservationLink;
}
