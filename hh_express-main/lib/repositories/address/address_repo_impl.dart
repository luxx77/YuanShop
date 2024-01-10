import 'package:hh_express/data/remote/dio_client.dart';
import 'package:hh_express/models/addres/address_model.dart';
import 'package:hh_express/models/pagination/pagination_model.dart';
import 'package:hh_express/repositories/address/address_repo.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRepo)
class AddressRepoImpl extends AddressRepo with DioClientMixin {
  @override
  Future<AddressModel?> create(String address) async {
    final response = await dio.post(
      endPoint: EndPoints.createAddres,
      data: {
        APIKeys.address: address,
      },
    );
    if (response.success) {
      return AddressModel.fromJson(response.data[APIKeys.address]);
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> read(int page) async {
    final response =
        await dio.get(endPoint: EndPoints.addressList, queryParameters: {
      APIKeys.page: page,
    });
    if (response.success) {
      final data =
          (response.data[APIKeys.products][APIKeys.data] as List<dynamic>)
              .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
              .toList();
      final pagination = PaginationModel.fromJson(
          response.data[APIKeys.products][APIKeys.pagination]);
      return {
        APIKeys.data: data,
        APIKeys.pagination: pagination,
      };
    }
    return null;
  }

  @override
  Future<AddressModel?> update(AddressModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.addressUpdate(model.uuid),
      data: {
        APIKeys.address: model.address,
      },
    );
    if (response.success) {
      return AddressModel.fromJson(response.data[APIKeys.address]);
    }
    return null;
  }

  @override
  Future<AddressModel?> fetch(String uuid) async {
    final response = await dio.get(endPoint: EndPoints.cartFetch(uuid));
    if (response.success) {
      return AddressModel.fromJson(response.data[APIKeys.address]);
    }
    return null;
  }
}
