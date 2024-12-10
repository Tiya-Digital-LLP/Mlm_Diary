import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/notification_count_entity.dart';

NotificationCountEntity $NotificationCountEntityFromJson(
    Map<String, dynamic> json) {
  final NotificationCountEntity notificationCountEntity = NotificationCountEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    notificationCountEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    notificationCountEntity.message = message;
  }
  final int? notificationCount = jsonConvert.convert<int>(
      json['notification_count']);
  if (notificationCount != null) {
    notificationCountEntity.notificationCount = notificationCount;
  }
  return notificationCountEntity;
}

Map<String, dynamic> $NotificationCountEntityToJson(
    NotificationCountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['notification_count'] = entity.notificationCount;
  return data;
}

extension NotificationCountEntityExtension on NotificationCountEntity {
  NotificationCountEntity copyWith({
    int? status,
    String? message,
    int? notificationCount,
  }) {
    return NotificationCountEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..notificationCount = notificationCount ?? this.notificationCount;
  }
}