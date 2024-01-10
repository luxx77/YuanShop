// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) => FilterModel(
      id: json['id'] as int,
      slug: json['slug'] as String,
      by_most_saled: json['by_most_saled'] as bool,
      by_news: json['by_news'] as bool,
      properties: (json['properties'] as List<dynamic>)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'properties': instance.properties,
      'by_most_saled': instance.by_most_saled,
      'by_news': instance.by_news,
    };
