part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  final OrderHistoryAPIState apiState;
  final List<OrderHistoryModel> models;
  final PaginationModel? pagination;

  const OrderHistoryState({
    required this.apiState,
    required this.models,
    this.pagination,
  });

  static final deftState = OrderHistoryState(
    apiState: OrderHistoryAPIState.init,
    models: List.empty(growable: true),
  );

  @override
  List<Object?> get props => [apiState, models, pagination];
}
