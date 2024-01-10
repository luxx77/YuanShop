import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Equatable {
  final String uuid;
  final String address;
  const AddressModel({
    required this.address,
    required this.uuid,
  });
  AddressModel update(String newAddress) {
    return AddressModel(
      address: newAddress,
      uuid: uuid,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object> get props => [uuid, address];
}
