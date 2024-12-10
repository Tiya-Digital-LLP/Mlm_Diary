import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/delete_user_post_entity.dart';

DeleteUserPostEntity $DeleteUserPostEntityFromJson(Map<String, dynamic> json) {
  final DeleteUserPostEntity deleteUserPostEntity = DeleteUserPostEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    deleteUserPostEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    deleteUserPostEntity.message = message;
  }
  return deleteUserPostEntity;
}

Map<String, dynamic> $DeleteUserPostEntityToJson(DeleteUserPostEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension DeleteUserPostEntityExtension on DeleteUserPostEntity {
  DeleteUserPostEntity copyWith({
    int? status,
    String? message,
  }) {
    return DeleteUserPostEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}