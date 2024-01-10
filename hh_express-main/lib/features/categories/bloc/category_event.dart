part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class ChangeCategory extends CategoryEvent {
  const ChangeCategory({
    required this.slug,
  });
  final String slug;

  @override
  List<Object> get props => [slug];
}

class InitCategories extends CategoryEvent {}
