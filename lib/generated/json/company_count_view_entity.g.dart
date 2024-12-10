import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/company_count_view_entity.dart';

CompanyCountViewEntity $CompanyCountViewEntityFromJson(
    Map<String, dynamic> json) {
  final CompanyCountViewEntity companyCountViewEntity = CompanyCountViewEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    companyCountViewEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    companyCountViewEntity.message = message;
  }
  return companyCountViewEntity;
}

Map<String, dynamic> $CompanyCountViewEntityToJson(
    CompanyCountViewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension CompanyCountViewEntityExtension on CompanyCountViewEntity {
  CompanyCountViewEntity copyWith({
    int? status,
    String? message,
  }) {
    return CompanyCountViewEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}