import 'package:json_annotation/json_annotation.dart' ;
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  const CategoryModel({
    required this.image,
    required this.name,
    required this.slug,
    required this.id,
  });
  final String name;
  @JsonKey(name: 'media')
  final String image;
  final int id;
  final String slug;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
