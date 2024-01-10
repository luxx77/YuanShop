// import 'package:hh_express/models/categories/category_model.dart';
// import 'package:hh_express/models/products/product_model.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'sub_category_model.g.dart';

// @JsonSerializable()
// class SubCategoryModel {
//   const SubCategoryModel(
//       {required this.image,
//       required this.name,
//       required this.products,
//       required this.slug,
//       required this.id});
//   final int id;
//   @JsonKey( name: 'media')
//   final String name;
//   final String image;
//   final String slug;
//   final List<ProductModel>? products;

//   factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
//       _$SubCategoryModelFromJson(json);
//   Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);
// }
