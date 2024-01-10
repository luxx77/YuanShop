import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  const NotificationModel({
    required this.date,
    required this.subTitle,
    required this.title,
    required this.id,
    this.is_seen = true,
  });
  final String subTitle;
  final String title;
  final int id;
  final String? date;
  final bool? is_seen;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
