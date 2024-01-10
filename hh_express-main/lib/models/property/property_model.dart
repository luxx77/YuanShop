import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'property_model.g.dart';

@JsonSerializable()
class PropertyModel {
  final String name;
  final List<PropertyValue> values;
  @JsonKey(includeFromJson: false)
  bool isColor;
  PropertyModel({
    required this.values,
    required this.name,
    this.isColor = false,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return _$PropertyModelFromJson(json)..paint();
  }
  Map<String, dynamic> toJson() => _$PropertyModelToJson(this);

  void paint() {
    if (this.values.any((element) => element.icon == null)) {
      return;
    }
    this.isColor = true;
    return this.values.forEach((element) => element.isColor = true);
  }
}
