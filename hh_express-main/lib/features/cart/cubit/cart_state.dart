part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState({
    required this.apiState,
    this.cart,
  });

  final CartAPIState apiState;
  final CartModel? cart;

  @override
  List<Object?> get props => [apiState, cart];
}
