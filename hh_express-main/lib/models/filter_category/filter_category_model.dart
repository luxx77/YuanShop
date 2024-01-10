import 'package:json_annotation/json_annotation.dart';
part 'filter_category_model.g.dart';

@JsonSerializable()
class FilterCategoryModel {
  final String name;
  final String image;
  final int id;
  final String slug;
  const FilterCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  factory FilterCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$FilterCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterCategoryModelToJson(this);
}
