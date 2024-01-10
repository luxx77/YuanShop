import 'package:hh_express/models/property/property_model.dart';
import 'package:hh_express/models/products/product_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_details_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductDetailsModel {
  final int id;
  bool isFavorite;
  final String name;
  final String description;
  final String price;
  final String salePrice;
  final String categorySlug;
  @JsonKey(name: 'discount_price')
  final String? discount;
  final List<String> images;
  final List<PropertyModel> properties;
  final List<ProductModel> similarProducts;

  ProductDetailsModel({
    required this.categorySlug,
    required this.isFavorite,
    required this.id,
    required this.images,
    required this.description,
    this.discount,
    required this.name,
    required this.price,
    required this.properties,
    required this.salePrice,
    this.similarProducts = const [],
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> data) {
    final properties = data[APIKeys.properties] as List;
    final simmilarProds = data[APIKeys.similarProducts] as List;
    final json = (data[APIKeys.product] as Map<String, dynamic>)
      ..addAll({
        APIKeys.properties: properties,
        APIKeys.similarProducts: simmilarProds,
      });
    return _$ProductDetailsModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}
