import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_company_entity.dart';

GetCompanyEntity $GetCompanyEntityFromJson(Map<String, dynamic> json) {
  final GetCompanyEntity getCompanyEntity = GetCompanyEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    getCompanyEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getCompanyEntity.message = message;
  }
  final List<String>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (data != null) {
    getCompanyEntity.data = data;
  }
  return getCompanyEntity;
}

Map<String, dynamic> $GetCompanyEntityToJson(GetCompanyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  data['data'] = entity.data;
  return data;
}

extension GetCompanyEntityExtension on GetCompanyEntity {
  GetCompanyEntity copyWith({
    int? result,
    String? message,
    List<String>? data,
  }) {
    return GetCompanyEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}