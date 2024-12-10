import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_company_with_selected_entity.dart';

GetCompanyWithSelectedEntity $GetCompanyWithSelectedEntityFromJson(
    Map<String, dynamic> json) {
  final GetCompanyWithSelectedEntity getCompanyWithSelectedEntity = GetCompanyWithSelectedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getCompanyWithSelectedEntity.status = status;
  }
  final List<GetCompanyWithSelectedCompany>? company = (json['company'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetCompanyWithSelectedCompany>(
          e) as GetCompanyWithSelectedCompany).toList();
  if (company != null) {
    getCompanyWithSelectedEntity.company = company;
  }
  return getCompanyWithSelectedEntity;
}

Map<String, dynamic> $GetCompanyWithSelectedEntityToJson(
    GetCompanyWithSelectedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['company'] = entity.company?.map((v) => v.toJson()).toList();
  return data;
}

extension GetCompanyWithSelectedEntityExtension on GetCompanyWithSelectedEntity {
  GetCompanyWithSelectedEntity copyWith({
    int? status,
    List<GetCompanyWithSelectedCompany>? company,
  }) {
    return GetCompanyWithSelectedEntity()
      ..status = status ?? this.status
      ..company = company ?? this.company;
  }
}

GetCompanyWithSelectedCompany $GetCompanyWithSelectedCompanyFromJson(
    Map<String, dynamic> json) {
  final GetCompanyWithSelectedCompany getCompanyWithSelectedCompany = GetCompanyWithSelectedCompany();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCompanyWithSelectedCompany.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCompanyWithSelectedCompany.name = name;
  }
  final bool? selected = jsonConvert.convert<bool>(json['selected']);
  if (selected != null) {
    getCompanyWithSelectedCompany.selected = selected;
  }
  return getCompanyWithSelectedCompany;
}

Map<String, dynamic> $GetCompanyWithSelectedCompanyToJson(
    GetCompanyWithSelectedCompany entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['selected'] = entity.selected;
  return data;
}

extension GetCompanyWithSelectedCompanyExtension on GetCompanyWithSelectedCompany {
  GetCompanyWithSelectedCompany copyWith({
    int? id,
    String? name,
    bool? selected,
  }) {
    return GetCompanyWithSelectedCompany()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..selected = selected ?? this.selected;
  }
}