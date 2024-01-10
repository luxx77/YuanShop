// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hh_express/models/products/product_model.dart';

class HomeVideoModel {
  final int id;
  final String name;
  final String url;
  final String? duration;
  final ProductModel product;
  HomeVideoModel({
    required this.id,
    required this.name,
    required this.url,
    this.duration = '00:00',
    required this.product,
  });

  HomeVideoModel copyWith({
    int? id,
    String? name,
    String? url,
    String? duration,
    ProductModel? product,
  }) {
    return HomeVideoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'duration': duration,
      'product': product.toJson(),
    };
  }

  factory HomeVideoModel.fromMap(Map<String, dynamic> map) {
    return HomeVideoModel(
      id: map['id'] as int,
      name: map['name'] as String,
      url: map['url'] as String,
      duration: map['duration'] != null ? map['duration'] as String : null,
      product: ProductModel.fromJson(map['product'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeVideoModel.fromJson(String source) =>
      HomeVideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeVideoModel(id: $id, name: $name, url: $url, duration: $duration, product: $product)';
  }

  @override
  bool operator ==(covariant HomeVideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.url == url &&
        other.duration == duration &&
        other.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        url.hashCode ^
        duration.hashCode ^
        product.hashCode;
  }
}
