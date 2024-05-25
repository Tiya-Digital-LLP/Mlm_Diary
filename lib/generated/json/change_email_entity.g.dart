import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/change_email_entity.dart';

ChangeEmailEntity $ChangeEmailEntityFromJson(Map<String, dynamic> json) {
  final ChangeEmailEntity changeEmailEntity = ChangeEmailEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    changeEmailEntity.result = result;
  }
  final String? messsage = jsonConvert.convert<String>(json['messsage']);
  if (messsage != null) {
    changeEmailEntity.messsage = messsage;
  }
  return changeEmailEntity;
}

Map<String, dynamic> $ChangeEmailEntityToJson(ChangeEmailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['messsage'] = entity.messsage;
  return data;
}

extension ChangeEmailEntityExtension on ChangeEmailEntity {
  ChangeEmailEntity copyWith({
    int? result,
    String? messsage,
  }) {
    return ChangeEmailEntity()
      ..result = result ?? this.result
      ..messsage = messsage ?? this.messsage;
  }
}