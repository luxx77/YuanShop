// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.state,
    this.pagination,
    this.prods,
    this.deliveryInfo,
  });
  final ProductAPIState state;
  final List<ProductModel>? prods;
  final DeliveryInfoModel? deliveryInfo;
  final PaginationModel? pagination;

  @override
  List<Object?> get props => [state, prods, deliveryInfo, pagination];
}
