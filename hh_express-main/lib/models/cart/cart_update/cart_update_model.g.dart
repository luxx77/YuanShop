// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartUpdateModel _$CartUpdateModelFromJson(Map<String, dynamic> json) =>
    CartUpdateModel(
      productId: json['product_id'] as int,
      properties:
          (json['properties'] as List<dynamic>).map((e) => e as int).toList(),
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$CartUpdateModelToJson(CartUpdateModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'properties': instance.properties,
      'quantity': instance.quantity,
    };
