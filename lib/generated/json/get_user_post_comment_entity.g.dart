import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_user_post_comment_entity.dart';

GetUserPostCommentEntity $GetUserPostCommentEntityFromJson(
    Map<String, dynamic> json) {
  final GetUserPostCommentEntity getUserPostCommentEntity = GetUserPostCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getUserPostCommentEntity.status = status;
  }
  final List<GetUserPostCommentData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetUserPostCommentData>(e) as GetUserPostCommentData)
      .toList();
  if (data != null) {
    getUserPostCommentEntity.data = data;
  }
  return getUserPostCommentEntity;
}

Map<String, dynamic> $GetUserPostCommentEntityToJson(
    GetUserPostCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetUserPostCommentEntityExtension on GetUserPostCommentEntity {
  GetUserPostCommentEntity copyWith({
    int? status,
    List<GetUserPostCommentData>? data,
  }) {
    return GetUserPostCommentEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetUserPostCommentData $GetUserPostCommentDataFromJson(
    Map<String, dynamic> json) {
  final GetUserPostCommentData getUserPostCommentData = GetUserPostCommentData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserPostCommentData.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getUserPostCommentData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getUserPostCommentData.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getUserPostCommentData.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getUserPostCommentData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getUserPostCommentData.userimage = userimage;
  }
  final List<
      GetUserPostCommentDataCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetUserPostCommentDataCommentsReplays>(
          e) as GetUserPostCommentDataCommentsReplays).toList();
  if (commentsReplays != null) {
    getUserPostCommentData.commentsReplays = commentsReplays;
  }
  return getUserPostCommentData;
}

Map<String, dynamic> $GetUserPostCommentDataToJson(
    GetUserPostCommentData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['comments_replays'] =
      entity.commentsReplays?.map((v) => v.toJson()).toList();
  return data;
}

extension GetUserPostCommentDataExtension on GetUserPostCommentData {
  GetUserPostCommentData copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetUserPostCommentDataCommentsReplays>? commentsReplays,
  }) {
    return GetUserPostCommentData()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetUserPostCommentDataCommentsReplays $GetUserPostCommentDataCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetUserPostCommentDataCommentsReplays getUserPostCommentDataCommentsReplays = GetUserPostCommentDataCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserPostCommentDataCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getUserPostCommentDataCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getUserPostCommentDataCommentsReplays.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getUserPostCommentDataCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getUserPostCommentDataCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getUserPostCommentDataCommentsReplays.userimage = userimage;
  }
  final List<
      GetUserPostCommentDataCommentsReplaysCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetUserPostCommentDataCommentsReplaysCommentsReplays>(
          e) as GetUserPostCommentDataCommentsReplaysCommentsReplays).toList();
  if (commentsReplays != null) {
    getUserPostCommentDataCommentsReplays.commentsReplays = commentsReplays;
  }
  return getUserPostCommentDataCommentsReplays;
}

Map<String, dynamic> $GetUserPostCommentDataCommentsReplaysToJson(
    GetUserPostCommentDataCommentsReplays entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['comments_replays'] =
      entity.commentsReplays?.map((v) => v.toJson()).toList();
  return data;
}

extension GetUserPostCommentDataCommentsReplaysExtension on GetUserPostCommentDataCommentsReplays {
  GetUserPostCommentDataCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetUserPostCommentDataCommentsReplaysCommentsReplays>? commentsReplays,
  }) {
    return GetUserPostCommentDataCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetUserPostCommentDataCommentsReplaysCommentsReplays $GetUserPostCommentDataCommentsReplaysCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetUserPostCommentDataCommentsReplaysCommentsReplays getUserPostCommentDataCommentsReplaysCommentsReplays = GetUserPostCommentDataCommentsReplaysCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserPostCommentDataCommentsReplaysCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getUserPostCommentDataCommentsReplaysCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getUserPostCommentDataCommentsReplaysCommentsReplays.createdate =
        createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getUserPostCommentDataCommentsReplaysCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getUserPostCommentDataCommentsReplaysCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getUserPostCommentDataCommentsReplaysCommentsReplays.userimage = userimage;
  }
  final List<dynamic>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (commentsReplays != null) {
    getUserPostCommentDataCommentsReplaysCommentsReplays.commentsReplays =
        commentsReplays;
  }
  return getUserPostCommentDataCommentsReplaysCommentsReplays;
}

Map<String,
    dynamic> $GetUserPostCommentDataCommentsReplaysCommentsReplaysToJson(
    GetUserPostCommentDataCommentsReplaysCommentsReplays entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['comments_replays'] = entity.commentsReplays;
  return data;
}

extension GetUserPostCommentDataCommentsReplaysCommentsReplaysExtension on GetUserPostCommentDataCommentsReplaysCommentsReplays {
  GetUserPostCommentDataCommentsReplaysCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<dynamic>? commentsReplays,
  }) {
    return GetUserPostCommentDataCommentsReplaysCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}