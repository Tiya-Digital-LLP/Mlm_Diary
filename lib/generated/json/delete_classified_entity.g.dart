import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/delete_classified_entity.dart';

DeleteClassifiedEntity $DeleteClassifiedEntityFromJson(
    Map<String, dynamic> json) {
  final DeleteClassifiedEntity deleteClassifiedEntity = DeleteClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    deleteClassifiedEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    deleteClassifiedEntity.message = message;
  }
  return deleteClassifiedEntity;
}

Map<String, dynamic> $DeleteClassifiedEntityToJson(
    DeleteClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension DeleteClassifiedEntityExtension on DeleteClassifiedEntity {
  DeleteClassifiedEntity copyWith({
    int? status,
    String? message,
  }) {
    return DeleteClassifiedEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}