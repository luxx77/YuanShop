import 'package:hh_express/models/api/paginated_data_model.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/models/order_history/order_history_model.dart';

abstract class OrderRepo {
  Future<PaginatedDataModel<List<OrderHistoryModel>>?> getOrderHistory(
      int page);
  Future<CartModel?> getDetails(String uuid);
}
