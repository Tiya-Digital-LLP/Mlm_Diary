import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/delete_notification_entity.dart';

DeleteNotificationEntity $DeleteNotificationEntityFromJson(
    Map<String, dynamic> json) {
  final DeleteNotificationEntity deleteNotificationEntity = DeleteNotificationEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    deleteNotificationEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    deleteNotificationEntity.message = message;
  }
  return deleteNotificationEntity;
}

Map<String, dynamic> $DeleteNotificationEntityToJson(
    DeleteNotificationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension DeleteNotificationEntityExtension on DeleteNotificationEntity {
  DeleteNotificationEntity copyWith({
    int? status,
    String? message,
  }) {
    return DeleteNotificationEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}