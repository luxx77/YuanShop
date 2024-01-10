import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsageTermsModel {
  final String title;
  final String description;
  UsageTermsModel({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory UsageTermsModel.fromMap(Map<String, dynamic> map) {
    return UsageTermsModel(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsageTermsModel.fromJson(String source) =>
      UsageTermsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
