// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obs_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
      'cursor': instance.cursor,
    };
