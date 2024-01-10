// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      isFavorite: json['is_favorite'] as bool,
      description: json['description'] as String,
      id: json['id'] as int,
      image: json['images'] as String,
      name: json['name'] as String,
      categorySlug: json['category_slug'] as String? ?? 'null',
      discount: json['discount_price'] as String?,
      price: json['price'] as String,
      salePrice: json['sale_price'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'sale_price': instance.salePrice,
      'discount_price': instance.discount,
      'images': instance.image,
      'category_slug': instance.categorySlug,
      'is_favorite': instance.isFavorite,
    };
