

import 'package:hh_express/models/api/paginated_data_model.dart';
import 'package:hh_express/models/videos/video_model.dart';

abstract class VideoRepo {
  Future<PaginatedDataModel<List<HomeVideoModel>>?> getVideos(int page);
}