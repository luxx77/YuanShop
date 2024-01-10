// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

class PropertyValue {
  PropertyValue({
    required this.icon,
    required this.id,
    required this.value,
    this.property,
    this.isSelected = false,
    this.isColor = false,
  });
  final int id;
  final String? icon;
  final String? property;
  final String value;
  @JsonKey(includeFromJson: false)
  bool isSelected;
  @JsonKey(includeFromJson: false)
  bool isColor;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'icon': icon,
      'property': property,
      'value': value,
    };
  }

  factory PropertyValue.fromJson(Map<String, dynamic> map) {
    return PropertyValue(
      id: map['id'] as int,
      icon: map['icon'] != null ? map['icon'] as String : null,
      property: map['property'] != null ? map['property'] as String : null,
      value: map['value'] as String,
    );
  }
}
