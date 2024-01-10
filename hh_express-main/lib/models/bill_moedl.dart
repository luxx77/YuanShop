// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hh_express/models/cart/cart_model/cart_model.dart';

class BillModel {
  final String delivery_cost;
  final String weight_cost;
  final String total;
  final String sub_total;
  BillModel({
    required this.delivery_cost,
    required this.weight_cost,
    required this.total,
    required this.sub_total,
  });

  BillModel copyWith({
    String? delivery_cost,
    String? weight_cost,
    String? total,
    String? sub_total,
  }) {
    return BillModel(
      delivery_cost: delivery_cost ?? this.delivery_cost,
      weight_cost: weight_cost ?? this.weight_cost,
      total: total ?? this.total,
      sub_total: sub_total ?? this.sub_total,
    );
  }

  factory BillModel.fromCartModel(CartModel model) {
    return BillModel(
      delivery_cost: model.deliveryCost,
      weight_cost: model.weightCost,
      total: model.total,
      sub_total: model.subTotal,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'delivery_cost': delivery_cost,
      'weight_cost': weight_cost,
      'total': total,
      'sub_total': sub_total,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      delivery_cost: map['delivery_cost'] as String,
      weight_cost: map['weight_cost'] as String,
      total: map['total'] as String,
      sub_total: map['sub_total'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillModel.fromJson(String source) =>
      BillModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BillModel(delivery_cost: $delivery_cost, weight_cost: $weight_cost, total: $total, sub_total: $sub_total)';
  }

  @override
  bool operator ==(covariant BillModel other) {
    if (identical(this, other)) return true;

    return other.delivery_cost == delivery_cost &&
        other.weight_cost == weight_cost &&
        other.total == total &&
        other.sub_total == sub_total;
  }

  @override
  int get hashCode {
    return delivery_cost.hashCode ^
        weight_cost.hashCode ^
        total.hashCode ^
        sub_total.hashCode;
  }
}
