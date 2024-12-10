import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_comment_blog_entity.dart';

AddCommentBlogEntity $AddCommentBlogEntityFromJson(Map<String, dynamic> json) {
  final AddCommentBlogEntity addCommentBlogEntity = AddCommentBlogEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addCommentBlogEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addCommentBlogEntity.message = message;
  }
  final AddCommentBlogData? data = jsonConvert.convert<AddCommentBlogData>(
      json['data']);
  if (data != null) {
    addCommentBlogEntity.data = data;
  }
  return addCommentBlogEntity;
}

Map<String, dynamic> $AddCommentBlogEntityToJson(AddCommentBlogEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddCommentBlogEntityExtension on AddCommentBlogEntity {
  AddCommentBlogEntity copyWith({
    int? status,
    String? message,
    AddCommentBlogData? data,
  }) {
    return AddCommentBlogEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddCommentBlogData $AddCommentBlogDataFromJson(Map<String, dynamic> json) {
  final AddCommentBlogData addCommentBlogData = AddCommentBlogData();
  final String? bid = jsonConvert.convert<String>(json['bid']);
  if (bid != null) {
    addCommentBlogData.bid = bid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    addCommentBlogData.userid = userid;
  }
  final int? parentId = jsonConvert.convert<int>(json['parent_id']);
  if (parentId != null) {
    addCommentBlogData.parentId = parentId;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    addCommentBlogData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addCommentBlogData.createdate = createdate;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addCommentBlogData.id = id;
  }
  return addCommentBlogData;
}

Map<String, dynamic> $AddCommentBlogDataToJson(AddCommentBlogData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['bid'] = entity.bid;
  data['userid'] = entity.userid;
  data['parent_id'] = entity.parentId;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['id'] = entity.id;
  return data;
}

extension AddCommentBlogDataExtension on AddCommentBlogData {
  AddCommentBlogData copyWith({
    String? bid,
    int? userid,
    int? parentId,
    String? comment,
    String? createdate,
    int? id,
  }) {
    return AddCommentBlogData()
      ..bid = bid ?? this.bid
      ..userid = userid ?? this.userid
      ..parentId = parentId ?? this.parentId
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..id = id ?? this.id;
  }
}