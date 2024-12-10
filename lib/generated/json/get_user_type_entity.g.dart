import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_user_type_entity.dart';

GetUserTypeEntity $GetUserTypeEntityFromJson(Map<String, dynamic> json) {
  final GetUserTypeEntity getUserTypeEntity = GetUserTypeEntity();
  final List<GetUserTypeUsertype>? usertype = (json['usertype'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetUserTypeUsertype>(e) as GetUserTypeUsertype)
      .toList();
  if (usertype != null) {
    getUserTypeEntity.usertype = usertype;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getUserTypeEntity.status = status;
  }
  return getUserTypeEntity;
}

Map<String, dynamic> $GetUserTypeEntityToJson(GetUserTypeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['usertype'] = entity.usertype?.map((v) => v.toJson()).toList();
  data['status'] = entity.status;
  return data;
}

extension GetUserTypeEntityExtension on GetUserTypeEntity {
  GetUserTypeEntity copyWith({
    List<GetUserTypeUsertype>? usertype,
    int? status,
  }) {
    return GetUserTypeEntity()
      ..usertype = usertype ?? this.usertype
      ..status = status ?? this.status;
  }
}

GetUserTypeUsertype $GetUserTypeUsertypeFromJson(Map<String, dynamic> json) {
  final GetUserTypeUsertype getUserTypeUsertype = GetUserTypeUsertype();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserTypeUsertype.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getUserTypeUsertype.name = name;
  }
  return getUserTypeUsertype;
}

Map<String, dynamic> $GetUserTypeUsertypeToJson(GetUserTypeUsertype entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  return data;
}

extension GetUserTypeUsertypeExtension on GetUserTypeUsertype {
  GetUserTypeUsertype copyWith({
    int? id,
    String? name,
  }) {
    return GetUserTypeUsertype()
      ..id = id ?? this.id
      ..name = name ?? this.name;
  }
}