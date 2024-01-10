// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hh_express/models/cart/cart_product_model/cart_product_model.dart';

part 'cart_order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartOrderModel extends Equatable {
  final int quantity;
  @JsonKey(name: 'purchase')
  final CartProductModel product;
  final String id;
  final List<PropertyValue>? propertyValues;
  const CartOrderModel({
    required this.id,
    required this.product,
    required this.quantity,
    this.propertyValues = const [],
  });

  factory CartOrderModel.fromJson(Map<String, dynamic> json) {
    return _$CartOrderModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CartOrderModelToJson(this);

  CartOrderModel copyWith({
    int? quantity,
    List<PropertyValue>? selectedPropsId,
    CartProductModel? product,
    String? id,
  }) {
    return CartOrderModel(
      quantity: quantity ?? this.quantity,
      propertyValues: propertyValues ?? this.propertyValues,
      product: product ?? this.product,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'CartOrderModel(quantity: $quantity, selectedPropsId: ${propertyValues}, product: $product, id: $id)';
  }

  @override
  List<Object?> get props => [quantity, propertyValues, id, product];
}
