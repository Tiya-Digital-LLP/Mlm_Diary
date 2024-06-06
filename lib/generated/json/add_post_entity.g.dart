import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_post_entity.dart';

AddPostEntity $AddPostEntityFromJson(Map<String, dynamic> json) {
  final AddPostEntity addPostEntity = AddPostEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addPostEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addPostEntity.message = message;
  }
  final AddPostUserpost? userpost = jsonConvert.convert<AddPostUserpost>(
      json['userpost']);
  if (userpost != null) {
    addPostEntity.userpost = userpost;
  }
  return addPostEntity;
}

Map<String, dynamic> $AddPostEntityToJson(AddPostEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['userpost'] = entity.userpost?.toJson();
  return data;
}

extension AddPostEntityExtension on AddPostEntity {
  AddPostEntity copyWith({
    int? status,
    String? message,
    AddPostUserpost? userpost,
  }) {
    return AddPostEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..userpost = userpost ?? this.userpost;
  }
}

AddPostUserpost $AddPostUserpostFromJson(Map<String, dynamic> json) {
  final AddPostUserpost addPostUserpost = AddPostUserpost();
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    addPostUserpost.userid = userid;
  }
  final int? postid = jsonConvert.convert<int>(json['postid']);
  if (postid != null) {
    addPostUserpost.postid = postid;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addPostUserpost.createdate = createdate;
  }
  final String? comments = jsonConvert.convert<String>(json['comments']);
  if (comments != null) {
    addPostUserpost.comments = comments;
  }
  final dynamic attachment = json['attachment'];
  if (attachment != null) {
    addPostUserpost.attachment = attachment;
  }
  final String? comtype = jsonConvert.convert<String>(json['comtype']);
  if (comtype != null) {
    addPostUserpost.comtype = comtype;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addPostUserpost.id = id;
  }
  final dynamic attachmentPath = json['attachment_path'];
  if (attachmentPath != null) {
    addPostUserpost.attachmentPath = attachmentPath;
  }
  return addPostUserpost;
}

Map<String, dynamic> $AddPostUserpostToJson(AddPostUserpost entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userid'] = entity.userid;
  data['postid'] = entity.postid;
  data['createdate'] = entity.createdate;
  data['comments'] = entity.comments;
  data['attachment'] = entity.attachment;
  data['comtype'] = entity.comtype;
  data['id'] = entity.id;
  data['attachment_path'] = entity.attachmentPath;
  return data;
}

extension AddPostUserpostExtension on AddPostUserpost {
  AddPostUserpost copyWith({
    int? userid,
    int? postid,
    String? createdate,
    String? comments,
    dynamic attachment,
    String? comtype,
    int? id,
    dynamic attachmentPath,
  }) {
    return AddPostUserpost()
      ..userid = userid ?? this.userid
      ..postid = postid ?? this.postid
      ..createdate = createdate ?? this.createdate
      ..comments = comments ?? this.comments
      ..attachment = attachment ?? this.attachment
      ..comtype = comtype ?? this.comtype
      ..id = id ?? this.id
      ..attachmentPath = attachmentPath ?? this.attachmentPath;
  }
}