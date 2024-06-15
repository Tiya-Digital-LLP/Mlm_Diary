import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_comment_news_entity.dart';

AddCommentNewsEntity $AddCommentNewsEntityFromJson(Map<String, dynamic> json) {
  final AddCommentNewsEntity addCommentNewsEntity = AddCommentNewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addCommentNewsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addCommentNewsEntity.message = message;
  }
  final AddCommentNewsData? data = jsonConvert.convert<AddCommentNewsData>(
      json['data']);
  if (data != null) {
    addCommentNewsEntity.data = data;
  }
  return addCommentNewsEntity;
}

Map<String, dynamic> $AddCommentNewsEntityToJson(AddCommentNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddCommentNewsEntityExtension on AddCommentNewsEntity {
  AddCommentNewsEntity copyWith({
    int? status,
    String? message,
    AddCommentNewsData? data,
  }) {
    return AddCommentNewsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddCommentNewsData $AddCommentNewsDataFromJson(Map<String, dynamic> json) {
  final AddCommentNewsData addCommentNewsData = AddCommentNewsData();
  final String? nid = jsonConvert.convert<String>(json['nid']);
  if (nid != null) {
    addCommentNewsData.nid = nid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    addCommentNewsData.userid = userid;
  }
  final int? parentId = jsonConvert.convert<int>(json['parent_id']);
  if (parentId != null) {
    addCommentNewsData.parentId = parentId;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    addCommentNewsData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addCommentNewsData.createdate = createdate;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addCommentNewsData.id = id;
  }
  return addCommentNewsData;
}

Map<String, dynamic> $AddCommentNewsDataToJson(AddCommentNewsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nid'] = entity.nid;
  data['userid'] = entity.userid;
  data['parent_id'] = entity.parentId;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['id'] = entity.id;
  return data;
}

extension AddCommentNewsDataExtension on AddCommentNewsData {
  AddCommentNewsData copyWith({
    String? nid,
    int? userid,
    int? parentId,
    String? comment,
    String? createdate,
    int? id,
  }) {
    return AddCommentNewsData()
      ..nid = nid ?? this.nid
      ..userid = userid ?? this.userid
      ..parentId = parentId ?? this.parentId
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..id = id ?? this.id;
  }
}