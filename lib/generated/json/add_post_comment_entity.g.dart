import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_post_comment_entity.dart';

AddPostCommentEntity $AddPostCommentEntityFromJson(Map<String, dynamic> json) {
  final AddPostCommentEntity addPostCommentEntity = AddPostCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addPostCommentEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addPostCommentEntity.message = message;
  }
  final AddPostCommentData? data = jsonConvert.convert<AddPostCommentData>(
      json['data']);
  if (data != null) {
    addPostCommentEntity.data = data;
  }
  return addPostCommentEntity;
}

Map<String, dynamic> $AddPostCommentEntityToJson(AddPostCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddPostCommentEntityExtension on AddPostCommentEntity {
  AddPostCommentEntity copyWith({
    int? status,
    String? message,
    AddPostCommentData? data,
  }) {
    return AddPostCommentEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddPostCommentData $AddPostCommentDataFromJson(Map<String, dynamic> json) {
  final AddPostCommentData addPostCommentData = AddPostCommentData();
  final String? pid = jsonConvert.convert<String>(json['pid']);
  if (pid != null) {
    addPostCommentData.pid = pid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    addPostCommentData.userid = userid;
  }
  final String? parentId = jsonConvert.convert<String>(json['parent_id']);
  if (parentId != null) {
    addPostCommentData.parentId = parentId;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    addPostCommentData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addPostCommentData.createdate = createdate;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addPostCommentData.id = id;
  }
  return addPostCommentData;
}

Map<String, dynamic> $AddPostCommentDataToJson(AddPostCommentData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pid'] = entity.pid;
  data['userid'] = entity.userid;
  data['parent_id'] = entity.parentId;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['id'] = entity.id;
  return data;
}

extension AddPostCommentDataExtension on AddPostCommentData {
  AddPostCommentData copyWith({
    String? pid,
    int? userid,
    String? parentId,
    String? comment,
    String? createdate,
    int? id,
  }) {
    return AddPostCommentData()
      ..pid = pid ?? this.pid
      ..userid = userid ?? this.userid
      ..parentId = parentId ?? this.parentId
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..id = id ?? this.id;
  }
}