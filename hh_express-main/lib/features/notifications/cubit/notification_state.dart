// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hh_express/models/notifications/notification_model.dart';
import 'package:hh_express/settings/enums.dart';

class NotificationState {
  final APIState apiState;
  final List<NotificationModel>? notifications;
  final int newNotificationsCount;
  final int currentPage;
  NotificationState({
    this.apiState = APIState.init,
    this.notifications,
    this.newNotificationsCount = 0,
    this.currentPage = 1,
  });
}
