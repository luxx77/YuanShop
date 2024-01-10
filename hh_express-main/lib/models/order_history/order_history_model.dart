import 'package:hh_express/models/cart/cart_order_model/cart_order_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderHistoryModel {
  final String uuid;
  final String total;
  final String deliveryCost;
  final String subTotal;
  final String status;
  final String statusTrans;
  final String date;
  final String code;
  final List<CartOrderModel> orders;

  const OrderHistoryModel({
    required this.deliveryCost,
    required this.orders,
    required this.status,
    required this.statusTrans,
    required this.total,
    required this.subTotal,
    required this.uuid,
    this.code = '  ',
    required this.date,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderHistoryModelToJson(this);
}
