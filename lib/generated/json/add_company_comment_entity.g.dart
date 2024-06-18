import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_company_comment_entity.dart';

AddCompanyCommentEntity $AddCompanyCommentEntityFromJson(
    Map<String, dynamic> json) {
  final AddCompanyCommentEntity addCompanyCommentEntity = AddCompanyCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addCompanyCommentEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addCompanyCommentEntity.message = message;
  }
  final AddCompanyCommentData? data = jsonConvert.convert<
      AddCompanyCommentData>(json['data']);
  if (data != null) {
    addCompanyCommentEntity.data = data;
  }
  return addCompanyCommentEntity;
}

Map<String, dynamic> $AddCompanyCommentEntityToJson(
    AddCompanyCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddCompanyCommentEntityExtension on AddCompanyCommentEntity {
  AddCompanyCommentEntity copyWith({
    int? status,
    String? message,
    AddCompanyCommentData? data,
  }) {
    return AddCompanyCommentEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddCompanyCommentData $AddCompanyCommentDataFromJson(
    Map<String, dynamic> json) {
  final AddCompanyCommentData addCompanyCommentData = AddCompanyCommentData();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    addCompanyCommentData.oid = oid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    addCompanyCommentData.userid = userid;
  }
  final String? parentId = jsonConvert.convert<String>(json['parent_id']);
  if (parentId != null) {
    addCompanyCommentData.parentId = parentId;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    addCompanyCommentData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addCompanyCommentData.createdate = createdate;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addCompanyCommentData.id = id;
  }
  return addCompanyCommentData;
}

Map<String, dynamic> $AddCompanyCommentDataToJson(
    AddCompanyCommentData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['oid'] = entity.oid;
  data['userid'] = entity.userid;
  data['parent_id'] = entity.parentId;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['id'] = entity.id;
  return data;
}

extension AddCompanyCommentDataExtension on AddCompanyCommentData {
  AddCompanyCommentData copyWith({
    String? oid,
    int? userid,
    String? parentId,
    String? comment,
    String? createdate,
    int? id,
  }) {
    return AddCompanyCommentData()
      ..oid = oid ?? this.oid
      ..userid = userid ?? this.userid
      ..parentId = parentId ?? this.parentId
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..id = id ?? this.id;
  }
}