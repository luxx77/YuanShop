// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favors_bloc.dart';

class FavorsState extends Equatable {
  final FavorsAPIState apiState;
  final List<CartProductModel> models;
  final PaginationModel? pagination;

  const FavorsState({
    required this.apiState,
    required this.models,
    this.pagination,
  });

  static final deftState = FavorsState(
    apiState: FavorsAPIState.init,
    models: List.empty(growable: true),
  );

  @override
  List<Object?> get props => [apiState, models, pagination];

  FavorsState copyWith({
    FavorsAPIState? apiState,
    List<CartProductModel>? models,
    PaginationModel? pagination,
  }) {
    return FavorsState(
      apiState: apiState ?? this.apiState,
      models: models ?? this.models,
      pagination: pagination ?? this.pagination,
    );
  }
}
