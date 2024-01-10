// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      categorySlug: json['category_slug'] as String,
      isFavorite: json['is_favorite'] as bool,
      id: json['id'] as int,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      discount: json['discount_price'] as String?,
      name: json['name'] as String,
      price: json['price'] as String,
      properties: (json['properties'] as List<dynamic>)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      salePrice: json['sale_price'] as String,
      similarProducts: (json['similar_products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_favorite': instance.isFavorite,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'sale_price': instance.salePrice,
      'category_slug': instance.categorySlug,
      'discount_price': instance.discount,
      'images': instance.images,
      'properties': instance.properties,
      'similar_products': instance.similarProducts,
    };
