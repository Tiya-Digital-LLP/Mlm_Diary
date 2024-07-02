import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/version_check_entity.dart';

VersionCheckEntity $VersionCheckEntityFromJson(Map<String, dynamic> json) {
  final VersionCheckEntity versionCheckEntity = VersionCheckEntity();
  final int? success = jsonConvert.convert<int>(json['success']);
  if (success != null) {
    versionCheckEntity.success = success;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    versionCheckEntity.message = message;
  }
  return versionCheckEntity;
}

Map<String, dynamic> $VersionCheckEntityToJson(VersionCheckEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['message'] = entity.message;
  return data;
}

extension VersionCheckEntityExtension on VersionCheckEntity {
  VersionCheckEntity copyWith({
    int? success,
    String? message,
  }) {
    return VersionCheckEntity()
      ..success = success ?? this.success
      ..message = message ?? this.message;
  }
}