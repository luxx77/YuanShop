import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_details_state.dart';

class VideoDetailsCubit extends Cubit<VideoDetailsState> {
  VideoDetailsCubit() : super(VideoDetailsState(currentPage: -1, lastPage: -1));

  void changePage(int index) {
    emit(
      VideoDetailsState(
        currentPage: index,
        lastPage: state.currentPage,
      ),
    );
  }
}
