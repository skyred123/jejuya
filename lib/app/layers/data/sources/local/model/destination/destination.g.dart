// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Destination _$DestinationFromJson(Map<String, dynamic> json) => Destination(
      id: json['id'] as String,
      latitude: json['Latitude'] as String,
      longitude: json['Longitude'] as String,
      businessNameEnglish: json['BusinessNameEnglish'] as String,
      businessNameKorean: json['BusinessNameKorean'] as String,
      startTime: json['StartTime'] == null
          ? null
          : DateTime.parse(json['StartTime'] as String),
      endTime: json['EndTime'] == null
          ? null
          : DateTime.parse(json['EndTime'] as String),
    );

Map<String, dynamic> _$DestinationToJson(Destination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'businessNameEnglish': instance.businessNameEnglish,
      'businessNameKorean': instance.businessNameKorean,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };
