// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'simmilar_prods_cubit.dart';

class SimmilarProdsState extends Equatable {
  const SimmilarProdsState({
    required this.state,
    this.pagination,
    this.prods,
  });
  final ProductAPIState state;
  final List<ProductModel>? prods;
  final PaginationModel? pagination;

  @override
  List<Object?> get props => [state, prods, pagination];
}
