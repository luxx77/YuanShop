part of 'filter_bloc.dart';

@immutable
sealed class FilterEvent {
  const FilterEvent();
}

final class AddFilterProperty extends FilterEvent {
  const AddFilterProperty({
    required this.model,
  });
  final PropertyValue model;
}

final class RemoveFilterProperty extends FilterEvent {
  const RemoveFilterProperty({
    required this.model,
  });
  final PropertyValue model;
}

final class ClearFilter extends FilterEvent {}

final class FilterInit extends FilterEvent {}
