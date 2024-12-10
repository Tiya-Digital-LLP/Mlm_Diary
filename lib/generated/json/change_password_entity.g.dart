import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/change_password_entity.dart';

ChangePasswordEntity $ChangePasswordEntityFromJson(Map<String, dynamic> json) {
  final ChangePasswordEntity changePasswordEntity = ChangePasswordEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    changePasswordEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    changePasswordEntity.message = message;
  }
  return changePasswordEntity;
}

Map<String, dynamic> $ChangePasswordEntityToJson(ChangePasswordEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  return data;
}

extension ChangePasswordEntityExtension on ChangePasswordEntity {
  ChangePasswordEntity copyWith({
    int? result,
    String? message,
  }) {
    return ChangePasswordEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message;
  }
}