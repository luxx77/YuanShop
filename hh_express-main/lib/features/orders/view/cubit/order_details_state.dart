part of 'order_details_cubit.dart';

class OrderDetailsState extends Equatable {
  const OrderDetailsState({
    required this.apiState,
    this.model,
  });
  final CartModel? model;
  final APIState apiState;
  @override
  List<Object?> get props => [model, apiState];
}
