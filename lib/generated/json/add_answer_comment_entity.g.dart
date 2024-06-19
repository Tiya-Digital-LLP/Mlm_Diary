import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_answer_comment_entity.dart';

AddAnswerCommentEntity $AddAnswerCommentEntityFromJson(
    Map<String, dynamic> json) {
  final AddAnswerCommentEntity addAnswerCommentEntity = AddAnswerCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addAnswerCommentEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addAnswerCommentEntity.message = message;
  }
  final AddAnswerCommentData? data = jsonConvert.convert<AddAnswerCommentData>(
      json['data']);
  if (data != null) {
    addAnswerCommentEntity.data = data;
  }
  return addAnswerCommentEntity;
}

Map<String, dynamic> $AddAnswerCommentEntityToJson(
    AddAnswerCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddAnswerCommentEntityExtension on AddAnswerCommentEntity {
  AddAnswerCommentEntity copyWith({
    int? status,
    String? message,
    AddAnswerCommentData? data,
  }) {
    return AddAnswerCommentEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddAnswerCommentData $AddAnswerCommentDataFromJson(Map<String, dynamic> json) {
  final AddAnswerCommentData addAnswerCommentData = AddAnswerCommentData();
  final String? ancid = jsonConvert.convert<String>(json['ancid']);
  if (ancid != null) {
    addAnswerCommentData.ancid = ancid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    addAnswerCommentData.userid = userid;
  }
  final String? parentId = jsonConvert.convert<String>(json['parent_id']);
  if (parentId != null) {
    addAnswerCommentData.parentId = parentId;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    addAnswerCommentData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addAnswerCommentData.createdate = createdate;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addAnswerCommentData.id = id;
  }
  return addAnswerCommentData;
}

Map<String, dynamic> $AddAnswerCommentDataToJson(AddAnswerCommentData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ancid'] = entity.ancid;
  data['userid'] = entity.userid;
  data['parent_id'] = entity.parentId;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['id'] = entity.id;
  return data;
}

extension AddAnswerCommentDataExtension on AddAnswerCommentData {
  AddAnswerCommentData copyWith({
    String? ancid,
    int? userid,
    String? parentId,
    String? comment,
    String? createdate,
    int? id,
  }) {
    return AddAnswerCommentData()
      ..ancid = ancid ?? this.ancid
      ..userid = userid ?? this.userid
      ..parentId = parentId ?? this.parentId
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..id = id ?? this.id;
  }
}