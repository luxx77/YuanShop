import 'package:hh_express/data/remote/dio_client.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/models/cart/cart_update/cart_update_model.dart';
import 'package:hh_express/repositories/cart/cart_repository.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepo)
class CartRepoImpl extends CartRepo with DioClientMixin {
  Future<CartModel?> getCurrentCart() async {
    final response = await dio.get(endPoint: EndPoints.currentCart);
    if (response.success) {
      final model = CartModel.fromJson(response.data[APIKeys.cart]);
      return model;
    }
    return null;
  }

  Future<CartModel?> updateCart(CartUpdateModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.cartUpdate,
      data: model.toJson()..log(message: 'Upadte Data'),
    );
    if (response.success) {
      final model = CartModel.fromJson(response.data[APIKeys.cart]);
      return model;
    }
    return null;
  }

  Future<CartModel?> completeCart(String uuid) async {
    final response = await dio.post(endPoint: EndPoints.cartComplete, data: {
      'address_uuid': uuid,
    });
    if (response.success) {
      final model = CartModel.fromJson(response.data[APIKeys.cart]);
      return model;
    }
    return null;
  }

  Future<CartModel?> clearCart() async {
    final response = await dio.delete(endPoint: EndPoints.clearCart);
    if (response.success) {
      final data = response.data[APIKeys.cart];
      final model = CartModel.fromJson(data as Map<String, dynamic>);
      return model;
    }
    return null;
  }

  @override
  Future<CartModel?> getInstance(CartUpdateModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.cartInstance,
      data: model.toJson(),
    );
    if (response.success) {
      final model = CartModel.fromJson(response.data[APIKeys.cart]);
      return model;
    }
    return null;
  }

  @override
  Future<bool> completeInstance(String cartUuid, String addressUuid) async {
    final response = await dio.post(
      endPoint: EndPoints.cartCompleteInstance,
      data: {
        APIKeys.cartUuid: cartUuid,
        APIKeys.addressUuid: addressUuid,
      },
    );
    return response.success;
  }
}
