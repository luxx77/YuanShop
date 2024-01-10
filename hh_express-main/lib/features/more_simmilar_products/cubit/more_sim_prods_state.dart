// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'more_sim_prods_cubit.dart';

final class MoreSimProdsState extends Equatable {
  const MoreSimProdsState({
    required this.apiState,
    this.pagination,
    this.products,
  });

  final ProductAPIState apiState;
  final List<ProductModel>? products;
  final PaginationModel? pagination;

  @override
  List<Object?> get props => [apiState, products, pagination];

  MoreSimProdsState copyWith({
    ProductAPIState? apiState,
    List<ProductModel>? products,
    PaginationModel? pagination,
  }) {
    return MoreSimProdsState(
      apiState: apiState ?? this.apiState,
      products: products ?? this.products,
      pagination: pagination ?? this.pagination,
    );
  }
}
