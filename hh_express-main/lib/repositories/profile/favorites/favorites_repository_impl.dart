import 'package:hh_express/data/remote/dio_client.dart';
import 'package:hh_express/models/api/paginated_data_model.dart';
import 'package:hh_express/models/cart/cart_product_model/cart_product_model.dart';
import 'package:hh_express/models/pagination/pagination_model.dart';
import 'package:hh_express/repositories/profile/favorites/favorites_repository.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FavorsRepo)
class FavorsRepoImpl extends FavorsRepo with DioClientMixin {
  @override
  Future<bool?> switchFavor(int id) async {
    final response = await dio
        .post(endPoint: EndPoints.favorsSwitch, data: {'product_id': id});

    if (response.success) {
      return response.data[APIKeys.isFavor];
    }
    return null;
  }

  @override
  Future<PaginatedDataModel<List<CartProductModel>>?> getFavors(
      int page) async {
    final response = await dio.get(
      endPoint: EndPoints.favorsList,
      queryParameters: {APIKeys.page: page},
    );
    if (response.success) {
      final data = response.data[APIKeys.products];
      final favors = (data[APIKeys.data] as List)
          .map((e) => CartProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final pagination = PaginationModel.fromJson(data[APIKeys.pagination]);
      return PaginatedDataModel(data: favors, pagination: pagination);
    }
    return null;
  }
}
