import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/edit_comment_entity.dart';

EditCommentEntity $EditCommentEntityFromJson(Map<String, dynamic> json) {
  final EditCommentEntity editCommentEntity = EditCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    editCommentEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    editCommentEntity.message = message;
  }
  return editCommentEntity;
}

Map<String, dynamic> $EditCommentEntityToJson(EditCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension EditCommentEntityExtension on EditCommentEntity {
  EditCommentEntity copyWith({
    int? status,
    String? message,
  }) {
    return EditCommentEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}