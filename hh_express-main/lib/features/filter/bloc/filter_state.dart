part of 'filter_bloc.dart';

final class FilterState extends Equatable {
  const FilterState({
    required this.filterByNews,
    required this.properties,
    required this.prodByCatselecteds,
    required this.homeSelecteds,
    required this.state,
  });
  final FilterAPIState state;
  final List<PropertyValue> prodByCatselecteds;
  final List<PropertyValue> homeSelecteds;
  final List<PropertyModel>? properties;
  final bool filterByNews;

  @override
  List<Object?> get props => [
        state,
        homeSelecteds,
        prodByCatselecteds,
        properties,
        filterByNews,
      ];

  factory FilterState.empty(FilterAPIState state) {
    return FilterState(
      filterByNews: false,
      properties: List.empty(growable: true),
      prodByCatselecteds: List.empty(growable: true),
      homeSelecteds: List.empty(growable: true),
      state: state,
    );
  }

  factory FilterState.update(FilterState oldState) {
    return FilterState(
      filterByNews: false,
      properties: List.from(oldState.properties!),
      prodByCatselecteds: List.from(oldState.prodByCatselecteds),
      homeSelecteds: List.from(oldState.homeSelecteds),
      state: FilterAPIState.success,
    );
  }
}
