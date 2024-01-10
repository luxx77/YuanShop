// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      count: json['count'] as int,
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
      nextPageUrl: json['next_page_url'] as String?,
      prevPageUrl: json['prev_page_url'] as String?,
      perPage: json['per_page'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'prev_page_url': instance.prevPageUrl,
      'next_page_url': instance.nextPageUrl,
      'per_page': instance.perPage,
      'count': instance.count,
      'total': instance.total,
    };
