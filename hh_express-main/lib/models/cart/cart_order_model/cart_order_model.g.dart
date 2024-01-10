// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartOrderModel _$CartOrderModelFromJson(Map<String, dynamic> json) =>
    CartOrderModel(
      id: json['id'] as String,
      product:
          CartProductModel.fromJson(json['purchase'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      propertyValues: (json['property_values'] as List<dynamic>?)
              ?.map((e) => PropertyValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CartOrderModelToJson(CartOrderModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'purchase': instance.product,
      'id': instance.id,
      'property_values': instance.propertyValues,
    };
