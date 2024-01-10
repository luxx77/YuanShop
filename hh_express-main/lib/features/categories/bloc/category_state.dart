part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.activIndex,
    this.mains,
    required this.state,
    this.cancelToken,
    this.subs,
  });
  final CategoryAPIState state;
  final int? activIndex;
  final List<CategoryModel>? mains;

  /// saving subs by parent slug
  final Map<String, List<CategoryModel>>? subs;
  final CancelToken? cancelToken;

  @override
  List<Object?> get props => [mains, state, activIndex, subs, cancelToken];
}
