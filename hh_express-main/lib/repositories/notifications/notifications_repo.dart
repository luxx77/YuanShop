import 'package:dio/dio.dart';
import 'package:hh_express/models/api/response_model.dart';

abstract class NotificationsRepo {
  Future<ApiResponse> getNotificationsList(
    CancelToken cancelToken,
  );

  Future<ApiResponse> deleteNotification(int id);
  Future<int?> getNotificationCount();
}
