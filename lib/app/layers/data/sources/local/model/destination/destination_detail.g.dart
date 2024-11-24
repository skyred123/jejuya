// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationDetail _$DestinationDetailFromJson(Map<String, dynamic> json) {
  try {
    var item = DestinationDetail(
      id: json['id'] as String? ?? '',
      turn: json['Turn'] as String? ?? '',
      categoryEnglish: json['CategoryEnglish'] as String? ?? '',
      categoryKorean: json['CategoryKorean'] as String? ?? '',
      detailedCategoryEnglish: json['DetailedCategoryEnglish'] as String? ?? '',
      detailedCategoryKorean: json['DetailedCategoryKorean'] as String? ?? '',
      introductionEnglish: json['IntroductionEnglish'] as String? ?? '',
      introductionKorean: json['IntroductionKorean'] as String? ?? '',
      businessNameEnglish: json['BusinessNameEnglish'] as String? ?? '',
      businessNameKorean: json['BusinessNameKorean'] as String? ?? '',
      locationEnglish: json['LocationEnglish'] as String? ?? '',
      locationKorean: json['LocationKorean'] as String? ?? '',
      latitude: json['Latitude'] as String? ?? '',
      longitude: json['Longitude'] as String? ?? '',
      contact: json['Contact'] as String? ?? '',
      operatingHoursEnglish: json['OperatingHoursEnglish'] as String? ?? '',
      operatingHoursKorean: json['OperatingHoursKorean'] as String? ?? '',
      closedDaysEnglish: json['ClosedDaysEnglish'] as String? ?? '',
      closedDaysKorean: json['ClosedDaysKorean'] as String? ?? '',
      noteEnglish: json['NoteEnglish'] as String? ?? '',
      noteKorean: json['NoteKorean'] as String? ?? '',
      reservationLink: json['ReservationLink'] as String? ?? '',
    );
    return item;
  } catch (e) {
    // Xử lý lỗi, chẳng hạn ghi log hoặc trả về đối tượng mặc định
    print('Error parsing JSON: $e');
    return DestinationDetail(
      id: '',
      turn: '0',
      categoryEnglish: '',
      categoryKorean: '',
      detailedCategoryEnglish: '',
      detailedCategoryKorean: '',
      introductionEnglish: '',
      introductionKorean: '',
      businessNameEnglish: '',
      businessNameKorean: '',
      locationEnglish: '',
      locationKorean: '',
      latitude: '',
      longitude: '',
      contact: '',
      operatingHoursEnglish: '',
      operatingHoursKorean: '',
      closedDaysEnglish: '',
      closedDaysKorean: '',
      noteEnglish: '',
      noteKorean: '',
      reservationLink: '',
    );
  }
}

Map<String, dynamic> _$DestinationDetailToJson(DestinationDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'turn': instance.turn,
      'categoryEnglish': instance.categoryEnglish,
      'categoryKorean': instance.categoryKorean,
      'detailedCategoryEnglish': instance.detailedCategoryEnglish,
      'detailedCategoryKorean': instance.detailedCategoryKorean,
      'introductionEnglish': instance.introductionEnglish,
      'introductionKorean': instance.introductionKorean,
      'businessNameEnglish': instance.businessNameEnglish,
      'businessNameKorean': instance.businessNameKorean,
      'locationEnglish': instance.locationEnglish,
      'locationKorean': instance.locationKorean,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'contact': instance.contact,
      'operatingHoursEnglish': instance.operatingHoursEnglish,
      'operatingHoursKorean': instance.operatingHoursKorean,
      'closedDaysEnglish': instance.closedDaysEnglish,
      'closedDaysKorean': instance.closedDaysKorean,
      'noteEnglish': instance.noteEnglish,
      'noteKorean': instance.noteKorean,
      'reservationLink': instance.reservationLink,
    };
