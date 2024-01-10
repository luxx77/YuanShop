part of 'product_details_bloc.dart';

class ProductDetailsState extends Equatable {
  final ProdDetailsAPIState state;
  final ProductDetailsModel? product;
  final CancelToken? cancelToken;
  final Map<String, int> selectedProps;
  ProductDetailsState({
    this.product,
    required this.state,
    this.cancelToken,
    this.selectedProps = const {},
  });

  @override
  List<Object?> get props => [state, product, cancelToken];
}
