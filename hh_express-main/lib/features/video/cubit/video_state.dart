// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_cubit.dart';

final class VideoState extends Equatable {
  final ProductAPIState apiState;
  final List<HomeVideoModel> models;
  final PaginationModel? pagination;
  VideoState({
    required this.apiState,
    this.models = const [],
    this.pagination,
  });
  @override
  List<Object?> get props => [apiState, pagination, models];

  VideoState copyWith({
    ProductAPIState? apiState,
    List<HomeVideoModel>? models,
    PaginationModel? pagination,
  }) {
    return VideoState(
      apiState: apiState ?? this.apiState,
      models: models ?? this.models,
      pagination: pagination ?? this.pagination,
    );
  }
}
