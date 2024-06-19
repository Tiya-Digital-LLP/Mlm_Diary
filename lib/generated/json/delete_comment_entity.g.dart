import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/delete_comment_entity.dart';

DeleteCommentEntity $DeleteCommentEntityFromJson(Map<String, dynamic> json) {
  final DeleteCommentEntity deleteCommentEntity = DeleteCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    deleteCommentEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    deleteCommentEntity.message = message;
  }
  return deleteCommentEntity;
}

Map<String, dynamic> $DeleteCommentEntityToJson(DeleteCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension DeleteCommentEntityExtension on DeleteCommentEntity {
  DeleteCommentEntity copyWith({
    int? status,
    String? message,
  }) {
    return DeleteCommentEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}