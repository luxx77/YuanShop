part of 'video_details_cubit.dart';

class VideoDetailsState extends Equatable {
  const VideoDetailsState({
    required this.currentPage,
    required this.lastPage,
  });
  final int currentPage;
  final int lastPage;
  @override
  List<Object> get props => [currentPage, lastPage];
}
