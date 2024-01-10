import 'package:hh_express/models/api/paginated_data_model.dart';
import 'package:hh_express/models/cart/cart_product_model/cart_product_model.dart';

abstract class FavorsRepo {
  Future<PaginatedDataModel<List<CartProductModel>>?> getFavors(int page);
  Future<bool?> switchFavor(int id);
}
