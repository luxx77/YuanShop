import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/models/cart/cart_update/cart_update_model.dart';

abstract class CartRepo {
  Future<CartModel?> getCurrentCart();
  Future<CartModel?> updateCart(CartUpdateModel model);
  Future<CartModel?> completeCart(String uuid);
  Future<CartModel?> clearCart();
  Future<CartModel?> getInstance(CartUpdateModel model);
  Future<bool> completeInstance(String cartUuid, String addressUuid);
}
