import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/classified_count_view_entity.dart';

ClassifiedCountViewEntity $ClassifiedCountViewEntityFromJson(
    Map<String, dynamic> json) {
  final ClassifiedCountViewEntity classifiedCountViewEntity = ClassifiedCountViewEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    classifiedCountViewEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    classifiedCountViewEntity.message = message;
  }
  return classifiedCountViewEntity;
}

Map<String, dynamic> $ClassifiedCountViewEntityToJson(
    ClassifiedCountViewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension ClassifiedCountViewEntityExtension on ClassifiedCountViewEntity {
  ClassifiedCountViewEntity copyWith({
    int? status,
    String? message,
  }) {
    return ClassifiedCountViewEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}