import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/data/local/secured_storage.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/overlay_helper.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/models/cart/cart_update/cart_update_model.dart';
import 'package:hh_express/repositories/cart/cart_repository.dart';
import 'package:hh_express/settings/enums.dart';
import 'package:hh_express/helpers/routes.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(apiState: CartAPIState.init));
  final _repo = getIt<CartRepo>();
  Future<void> getCurrentCart() async {
    emit(
      CartState(
        apiState: CartAPIState.loading,
        cart: state.cart,
      ),
    );
    if (LocalStorage.getToken == null) {
      emit(
        CartState(
          apiState: CartAPIState.unAuthorized,
          cart: state.cart,
        ),
      );
      return;
    }
    final data = await _repo.getCurrentCart();
    if (data != null) {
      emit(
        CartState(
          apiState: CartAPIState.success,
          cart: data,
        ),
      );
      return;
    }
    emit(
      CartState(
        apiState: CartAPIState.error,
        cart: data,
      ),
    );
  }

  /// returns is success
  Future<bool> cartUpdate(CartUpdateModel model) async {
    OverlayHelper.showLoading();
    final data = await _repo.updateCart(model);
    var value = false;
    if (data != null) {
      emit(
        CartState(
          apiState: CartAPIState.success,
          cart: data,
        ),
      );
      value = true;
    }
    final l10n = appRouter.currentContext.l10n;
    SnackBarHelper.showMessageSnack(
        data != null ? l10n.succsess : l10n.socketExeption);
    emit(
      CartState(
        apiState: CartAPIState.success,
        cart: data == null ? state.cart : data,
      ),
    );
    OverlayHelper.remove();
    return value;
  }

  int getQuantity(int id, {List? selectedProps}) {
    if (state.apiState == CartAPIState.unAuthorized) {
      return 0;
    }
    final list = state.cart!.orders.map((e) => e.product.id).toList();
    final index = list.indexOf(id);
    if (index == -1) {
      return 0;
    }

    return state.cart!.orders[index].quantity;
  }

  Future<void> complete(String uuid) async {
    OverlayHelper.showLoading();
    final data = await _repo.completeCart(uuid);
    final l10n = appRouter.currentContext.l10n;
    final isSucceed = data != null;
    if (isSucceed) {
      emit(
        CartState(
          apiState: CartAPIState.success,
          cart: data,
        ),
      );
    }
    SnackBarHelper.showTopSnack(
      isSucceed ? l10n.succsess : l10n.socketExeption,
      isSucceed ? APIState.success : APIState.error,
    );

    OverlayHelper.remove();
  }

  Future<void> completeInstance(String uuid, String addressUuid) async {
    final l10n = appRouter.currentContext.l10n;
    OverlayHelper.showLoading();
    final data = await _repo.completeInstance(uuid, addressUuid);
    SnackBarHelper.showTopSnack(
      data ? l10n.succsess : l10n.socketExeption,
      data ? APIState.success : APIState.error,
    );
    OverlayHelper.remove();
  }
}
