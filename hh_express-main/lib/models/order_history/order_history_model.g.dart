// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryModel _$OrderHistoryModelFromJson(Map<String, dynamic> json) =>
    OrderHistoryModel(
      deliveryCost: json['delivery_cost'] as String,
      orders: (json['orders'] as List<dynamic>)
          .map((e) => CartOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      statusTrans: json['status_trans'] as String,
      total: json['total'] as String,
      subTotal: json['sub_total'] as String,
      uuid: json['uuid'] as String,
      code: json['code'] as String? ?? ' ',
      date: json['date'] as String,
    );

Map<String, dynamic> _$OrderHistoryModelToJson(OrderHistoryModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'total': instance.total,
      'delivery_cost': instance.deliveryCost,
      'sub_total': instance.subTotal,
      'status': instance.status,
      'status_trans': instance.statusTrans,
      'date': instance.date,
      'code': instance.code,
      'orders': instance.orders,
    };
