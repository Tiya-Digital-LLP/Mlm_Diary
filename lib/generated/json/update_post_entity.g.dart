import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_post_entity.dart';

UpdatePostEntity $UpdatePostEntityFromJson(Map<String, dynamic> json) {
  final UpdatePostEntity updatePostEntity = UpdatePostEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updatePostEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updatePostEntity.message = message;
  }
  final UpdatePostUserpost? userpost = jsonConvert.convert<UpdatePostUserpost>(
      json['userpost']);
  if (userpost != null) {
    updatePostEntity.userpost = userpost;
  }
  return updatePostEntity;
}

Map<String, dynamic> $UpdatePostEntityToJson(UpdatePostEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['userpost'] = entity.userpost?.toJson();
  return data;
}

extension UpdatePostEntityExtension on UpdatePostEntity {
  UpdatePostEntity copyWith({
    int? status,
    String? message,
    UpdatePostUserpost? userpost,
  }) {
    return UpdatePostEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..userpost = userpost ?? this.userpost;
  }
}

UpdatePostUserpost $UpdatePostUserpostFromJson(Map<String, dynamic> json) {
  final UpdatePostUserpost updatePostUserpost = UpdatePostUserpost();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    updatePostUserpost.id = id;
  }
  final String? userid = jsonConvert.convert<String>(json['userid']);
  if (userid != null) {
    updatePostUserpost.userid = userid;
  }
  final String? comments = jsonConvert.convert<String>(json['comments']);
  if (comments != null) {
    updatePostUserpost.comments = comments;
  }
  final String? attachment = jsonConvert.convert<String>(json['attachment']);
  if (attachment != null) {
    updatePostUserpost.attachment = attachment;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    updatePostUserpost.pgcnt = pgcnt;
  }
  final String? comtype = jsonConvert.convert<String>(json['comtype']);
  if (comtype != null) {
    updatePostUserpost.comtype = comtype;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    updatePostUserpost.createdate = createdate;
  }
  final dynamic status = json['status'];
  if (status != null) {
    updatePostUserpost.status = status;
  }
  final String? postid = jsonConvert.convert<String>(json['postid']);
  if (postid != null) {
    updatePostUserpost.postid = postid;
  }
  final String? attachmentPath = jsonConvert.convert<String>(
      json['attachment_path']);
  if (attachmentPath != null) {
    updatePostUserpost.attachmentPath = attachmentPath;
  }
  return updatePostUserpost;
}

Map<String, dynamic> $UpdatePostUserpostToJson(UpdatePostUserpost entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['userid'] = entity.userid;
  data['comments'] = entity.comments;
  data['attachment'] = entity.attachment;
  data['pgcnt'] = entity.pgcnt;
  data['comtype'] = entity.comtype;
  data['createdate'] = entity.createdate;
  data['status'] = entity.status;
  data['postid'] = entity.postid;
  data['attachment_path'] = entity.attachmentPath;
  return data;
}

extension UpdatePostUserpostExtension on UpdatePostUserpost {
  UpdatePostUserpost copyWith({
    int? id,
    String? userid,
    String? comments,
    String? attachment,
    int? pgcnt,
    String? comtype,
    String? createdate,
    dynamic status,
    String? postid,
    String? attachmentPath,
  }) {
    return UpdatePostUserpost()
      ..id = id ?? this.id
      ..userid = userid ?? this.userid
      ..comments = comments ?? this.comments
      ..attachment = attachment ?? this.attachment
      ..pgcnt = pgcnt ?? this.pgcnt
      ..comtype = comtype ?? this.comtype
      ..createdate = createdate ?? this.createdate
      ..status = status ?? this.status
      ..postid = postid ?? this.postid
      ..attachmentPath = attachmentPath ?? this.attachmentPath;
  }
}