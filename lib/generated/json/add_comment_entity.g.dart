import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_comment_entity.dart';

AddCommentEntity $AddCommentEntityFromJson(Map<String, dynamic> json) {
  final AddCommentEntity addCommentEntity = AddCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addCommentEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addCommentEntity.message = message;
  }
  final AddCommentData? data = jsonConvert.convert<AddCommentData>(
      json['data']);
  if (data != null) {
    addCommentEntity.data = data;
  }
  return addCommentEntity;
}

Map<String, dynamic> $AddCommentEntityToJson(AddCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddCommentEntityExtension on AddCommentEntity {
  AddCommentEntity copyWith({
    int? status,
    String? message,
    AddCommentData? data,
  }) {
    return AddCommentEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddCommentData $AddCommentDataFromJson(Map<String, dynamic> json) {
  final AddCommentData addCommentData = AddCommentData();
  final String? cid = jsonConvert.convert<String>(json['cid']);
  if (cid != null) {
    addCommentData.cid = cid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    addCommentData.userid = userid;
  }
  final int? parentId = jsonConvert.convert<int>(json['parent_id']);
  if (parentId != null) {
    addCommentData.parentId = parentId;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    addCommentData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addCommentData.createdate = createdate;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addCommentData.id = id;
  }
  return addCommentData;
}

Map<String, dynamic> $AddCommentDataToJson(AddCommentData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cid'] = entity.cid;
  data['userid'] = entity.userid;
  data['parent_id'] = entity.parentId;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['id'] = entity.id;
  return data;
}

extension AddCommentDataExtension on AddCommentData {
  AddCommentData copyWith({
    String? cid,
    int? userid,
    int? parentId,
    String? comment,
    String? createdate,
    int? id,
  }) {
    return AddCommentData()
      ..cid = cid ?? this.cid
      ..userid = userid ?? this.userid
      ..parentId = parentId ?? this.parentId
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..id = id ?? this.id;
  }
}