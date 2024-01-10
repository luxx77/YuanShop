// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hh_express/models/cart/cart_order_model/cart_order_model.dart';

part 'cart_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartModel extends Equatable {
  CartModel({
    required this.stateHistory,
    required this.uuid,
    required this.total,
    required this.subTotal,
    required this.weightCost,
    required this.deliveryCost,
    required this.date,
    required this.status,
    required this.statusTrans,
    this.code = ' ',
    this.orders = const [],
  });
  final String uuid;
  final String code;
  final String total;
  final String subTotal;
  final String weightCost;
  final String deliveryCost;
  final String date;
  final String status;
  final String statusTrans;
  final List<CartOrderModel> orders;
  final List<OrderStateModel> stateHistory;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return _$CartModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  @override
  List<Object?> get props => [
        uuid,
        total,
        subTotal,
        weightCost,
        deliveryCost,
        orders,
        status,
        stateHistory,
        statusTrans
      ];

  //!
}

class OrderStateModel {
  OrderStateModel({
    required this.state,
    this.completed_at,
  });
  final String? completed_at;
  final String state;
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'state': state,
      'completed_at': completed_at,
    };
  }

  factory OrderStateModel.fromJson(Map<String, dynamic> map) {
    return OrderStateModel(
      state: map['state'] as String,
      completed_at:
          map['completed_at'] != null ? map['completed_at'] as String : null,
    );
  }
}
