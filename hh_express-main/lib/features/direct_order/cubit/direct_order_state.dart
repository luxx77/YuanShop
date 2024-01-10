// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'direct_order_cubit.dart';

final class DirectOrderState extends Equatable {
  const DirectOrderState({
    this.cartModel,
    required this.apiState,
  });
  final CartModel? cartModel;
  final APIState apiState;
  @override
  List<Object?> get props => [apiState, cartModel, cartModel];

  DirectOrderState copyWith({
    CartModel? cartModel,
    APIState? apiState,
  }) {
    return DirectOrderState(
      cartModel: cartModel ?? this.cartModel,
      apiState: apiState ?? this.apiState,
    );
  }
}
