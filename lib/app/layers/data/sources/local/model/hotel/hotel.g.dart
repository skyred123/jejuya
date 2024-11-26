// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) {
  try {
    var item = Hotel(
      id: json['id'] as String? ?? '',
      businessNameEnglish: json['BusinessNameEnglish'] as String? ?? '',
      businessNameKorean: json['BusinessNameKorean'] as String? ?? '',
      latitude: json['Latitude'] as String? ?? '',
      longitude: json['Longitude'] as String? ?? '',
      contact: json['Contact'] as String? ?? '',
      noteEnglish: json['NoteEnglish'] as String? ?? '',
      noteKorean: json['NoteKorean'] as String? ?? '',
      roadNameAdressEnglish: json['RoadNameAdressEnglish'] as String? ?? '',
      roadNameAdressKorean: json['RoadNameAdressKorean'] as String? ?? '',
      numberOfRooms: json['NumberOfRooms'] as String? ?? '',
    );
    return item;
  } catch (e) {
    // Handle the error, e.g., log the error or return a default instance
    print('Error parsing JSON: $e');
    return Hotel(
      id: '',
      businessNameEnglish: '',
      businessNameKorean: '',
      latitude: '',
      longitude: '',
      contact: '',
      noteEnglish: '',
      noteKorean: '',
      roadNameAdressEnglish: '',
      roadNameAdressKorean: '',
      numberOfRooms: '',
    );
  }
}

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'id': instance.id,
      'businessNameEnglish': instance.businessNameEnglish,
      'businessNameKorean': instance.businessNameKorean,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'contact': instance.contact,
      'noteEnglish': instance.noteEnglish,
      'noteKorean': instance.noteKorean,
      'roadNameAdressEnglish': instance.roadNameAdressEnglish,
      'roadNameAdressKorean': instance.roadNameAdressKorean,
      'numberOfRooms': instance.numberOfRooms,
    };
