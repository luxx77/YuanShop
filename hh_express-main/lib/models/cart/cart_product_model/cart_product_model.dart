import 'package:json_annotation/json_annotation.dart';

part 'cart_product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartProductModel {
  final int id;
  final String name;
  final String description;
  @JsonKey(name: 'images')
  final String image;
  final String price;
  final String salePrice;
  final String? discountPrice;
  final bool isFavorite;
  const CartProductModel({
    required this.id,
    required this.image,
    required this.price,
    required this.description,
    required this.discountPrice,
    required this.name,
    required this.isFavorite,
    required this.salePrice,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return _$CartProductModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CartProductModelToJson(this);
}
