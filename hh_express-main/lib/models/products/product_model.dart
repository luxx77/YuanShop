import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String salePrice;
  @JsonKey(name: 'discount_price')
  final String? discount;
  @JsonKey(name: 'images')
  final String image;
  final String categorySlug;
  final bool isFavorite;

  const ProductModel({
    required this.isFavorite,
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    this.categorySlug = 'null',
    this.discount,
    required this.price,
    required this.salePrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
