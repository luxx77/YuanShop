part of 'products_by_category_bloc.dart';

final class ProductsByCategoryState extends Equatable {
  const ProductsByCategoryState({
    this.products,
    this.category,
    this.pagination,
    required this.state,
  });
  final ProductAPIState state;
  final List<ProductModel>? products;
  final CategoryModel? category;
  final PaginationModel? pagination;

  @override
  List<Object?> get props => [pagination, category, products, state];
}
