import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeliveryInfoValueModel {
  final String icon;
  final String text;
  DeliveryInfoValueModel({
    required this.icon,
    required this.text,
  });

  DeliveryInfoValueModel copyWith({
    String? icon,
    String? text,
  }) {
    return DeliveryInfoValueModel(
      icon: icon ?? this.icon,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon,
      'text': text,
    };
  }

  factory DeliveryInfoValueModel.fromMap(Map<String, dynamic> map) {
    return DeliveryInfoValueModel(
      icon: map['icon'] as String,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryInfoValueModel.fromJson(String source) =>
      DeliveryInfoValueModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeliveryInfoValueModel(icon: $icon, text: $text)';

  @override
  bool operator ==(covariant DeliveryInfoValueModel other) {
    if (identical(this, other)) return true;

    return other.icon == icon && other.text == text;
  }

  @override
  int get hashCode => icon.hashCode ^ text.hashCode;
}

//!
class DeliveryInfoModel {
  final List<DeliveryInfoValueModel> data;
  final String title;
  DeliveryInfoModel({
    required this.data,
    required this.title,
  });

  DeliveryInfoModel copyWith({
    List<DeliveryInfoValueModel>? data,
    String? title,
  }) {
    return DeliveryInfoModel(
      data: data ?? this.data,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'title': title,
    };
  }

  factory DeliveryInfoModel.fromMap(Map<String, dynamic> map) {
    return DeliveryInfoModel(
      data: List<DeliveryInfoValueModel>.from(
        (map['data'] as List<dynamic>).map<DeliveryInfoValueModel>(
          (x) => DeliveryInfoValueModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryInfoModel.fromJson(String source) =>
      DeliveryInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeliveryInfoModel(data: $data, title: $title)';

  @override
  bool operator ==(covariant DeliveryInfoModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) && other.title == title;
  }

  @override
  int get hashCode => data.hashCode ^ title.hashCode;
}
