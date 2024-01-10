part of 'search_cubit.dart';

class SearchState extends Equatable {
  final SearchAPIState apiState;
  final List<ProductModel>? models;
  final PaginationModel? pagination;
  const SearchState({
    required this.apiState,
    required this.models,
    required this.pagination,
  });

  SearchState update({
    final SearchAPIState? apiState,
    final List<ProductModel>? models,
    final PaginationModel? pagination,
  }) {
    return SearchState(
      apiState: apiState ?? this.apiState,
      models: models ?? this.models,
      pagination: pagination ?? this.pagination,
    );
  }

  static const initState = SearchState(
    apiState: SearchAPIState.init,
    models: null,
    pagination: null,
  );
  @override
  List<Object?> get props => [models, apiState, pagination];
}
