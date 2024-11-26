import 'package:json_annotation/json_annotation.dart';

part 'destinationDetail.g.dart';

/// Destination entity.
@JsonSerializable(
  explicitToJson: true,
)
class DestinationDetail {
  /// Default constructor for the [DestinationDetail].
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

  /// Factory constructor for the [DestinationDetail].
  factory DestinationDetail.fromJson(Map<String, dynamic> json) =>
      _$DestinationDetailFromJson(json);

  /// Converts the [DestinationDetail] to a JSON object.
  Map<String, dynamic> toJson() => _$DestinationDetailToJson(this);

  /// Destination Detail entity [id] property
  String id;

  /// Destination Detail entity [turn] property
  String turn;

  /// Destination Detail entity [categoryEnglish] property
  String categoryEnglish;

  /// Destination Detail entity [categoryKorean] property
  String categoryKorean;

  /// Destination Detail entity [detailedCategoryEnglish] property
  String detailedCategoryEnglish;

  /// Destination Detail entity [detailedCategoryKorean] property
  String detailedCategoryKorean;

  /// Destination Detail entity [introductionEnglish] property
  String introductionEnglish;

  /// Destination Detail entity [introductionKorean] property
  String introductionKorean;

  /// Destination Detail entity [businessNameEnglish] property
  String businessNameEnglish;

  /// Destination Detail entity [businessNameKorean] property
  String businessNameKorean;

  /// Destination Detail entity [locationEnglish] property
  String locationEnglish;

  /// Destination Detail entity [locationKorean] property
  String locationKorean;

  /// Destination Detail entity [latitude] property
  String latitude;

  /// Destination Detail entity [longitude] property
  String longitude;

  /// Destination Detail entity [contact] property
  String contact;

  /// Destination Detail entity [operatingHoursEnglish] property
  String operatingHoursEnglish;

  /// Destination Detail entity [operatingHoursKorean] property
  String operatingHoursKorean;

  /// Destination Detail entity [closedDaysEnglish] property
  String closedDaysEnglish;

  /// Destination Detail entity [closedDaysKorean] property
  String closedDaysKorean;

  /// Destination Detail entity [noteEnglish] property
  String noteEnglish;

  /// Destination Detail entity [noteKorean] property
  String noteKorean;

  /// Destination Detail entity [reservationLink] property
  String reservationLink;

  @override
  String toString() {
    return 'DestinationDetail{id: $id, businessNameEnglish: $businessNameEnglish, businessNameKorean: $businessNameKorean, locationEnglish: $locationEnglish, locationKorean: $locationKorean, latitude: $latitude, longitude: $longitude, contact: $contact, operatingHoursEnglish: $operatingHoursEnglish, operatingHoursKorean: $operatingHoursKorean, closedDaysEnglish: $closedDaysEnglish, closedDaysKorean: $closedDaysKorean, noteEnglish: $noteEnglish, noteKorean: $noteKorean, reservationLink: $reservationLink}';
  }
}
