// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      stateHistory: (json['state_history'] as List<dynamic>)
          .map((e) => OrderStateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      uuid: json['uuid'] as String,
      total: json['total'] as String,
      subTotal: json['sub_total'] as String,
      weightCost: json['weight_cost'] as String,
      deliveryCost: json['delivery_cost'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      statusTrans: json['status_trans'] as String,
      code: json['code'] as String? ?? ' ',
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) => CartOrderModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'code': instance.code,
      'total': instance.total,
      'sub_total': instance.subTotal,
      'weight_cost': instance.weightCost,
      'delivery_cost': instance.deliveryCost,
      'date': instance.date,
      'status': instance.status,
      'status_trans': instance.statusTrans,
      'orders': instance.orders,
      'state_history': instance.stateHistory,
    };
