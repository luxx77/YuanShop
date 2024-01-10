import 'package:hh_express/models/property/property_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter_model.g.dart';

@JsonSerializable()
class FilterModel {
  final int id;
  final String slug;
  final List<PropertyModel> properties;
  final bool by_most_saled;
  final bool by_news;
  const FilterModel({
    required this.id,
    required this.slug,
    required this.by_most_saled,
    required this.by_news,
    required this.properties,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterModelToJson(this);
}
