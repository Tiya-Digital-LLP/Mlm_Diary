import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_phone_no_entity.dart';

UpdatePhoneNoEntity $UpdatePhoneNoEntityFromJson(Map<String, dynamic> json) {
  final UpdatePhoneNoEntity updatePhoneNoEntity = UpdatePhoneNoEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updatePhoneNoEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updatePhoneNoEntity.message = message;
  }
  return updatePhoneNoEntity;
}

Map<String, dynamic> $UpdatePhoneNoEntityToJson(UpdatePhoneNoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension UpdatePhoneNoEntityExtension on UpdatePhoneNoEntity {
  UpdatePhoneNoEntity copyWith({
    int? status,
    String? message,
  }) {
    return UpdatePhoneNoEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}