// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterCategoryModel _$FilterCategoryModelFromJson(Map<String, dynamic> json) =>
    FilterCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$FilterCategoryModelToJson(
        FilterCategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'id': instance.id,
      'slug': instance.slug,
    };
