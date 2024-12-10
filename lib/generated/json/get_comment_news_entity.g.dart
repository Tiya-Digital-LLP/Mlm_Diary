import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_comment_news_entity.dart';

GetCommentNewsEntity $GetCommentNewsEntityFromJson(Map<String, dynamic> json) {
  final GetCommentNewsEntity getCommentNewsEntity = GetCommentNewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getCommentNewsEntity.status = status;
  }
  final List<GetCommentNewsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetCommentNewsData>(e) as GetCommentNewsData)
      .toList();
  if (data != null) {
    getCommentNewsEntity.data = data;
  }
  return getCommentNewsEntity;
}

Map<String, dynamic> $GetCommentNewsEntityToJson(GetCommentNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetCommentNewsEntityExtension on GetCommentNewsEntity {
  GetCommentNewsEntity copyWith({
    int? status,
    List<GetCommentNewsData>? data,
  }) {
    return GetCommentNewsEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetCommentNewsData $GetCommentNewsDataFromJson(Map<String, dynamic> json) {
  final GetCommentNewsData getCommentNewsData = GetCommentNewsData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCommentNewsData.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCommentNewsData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCommentNewsData.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCommentNewsData.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCommentNewsData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCommentNewsData.userimage = userimage;
  }
  final List<
      GetCommentNewsDataCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetCommentNewsDataCommentsReplays>(
          e) as GetCommentNewsDataCommentsReplays).toList();
  if (commentsReplays != null) {
    getCommentNewsData.commentsReplays = commentsReplays;
  }
  return getCommentNewsData;
}

Map<String, dynamic> $GetCommentNewsDataToJson(GetCommentNewsData entity) {
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

extension GetCommentNewsDataExtension on GetCommentNewsData {
  GetCommentNewsData copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetCommentNewsDataCommentsReplays>? commentsReplays,
  }) {
    return GetCommentNewsData()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetCommentNewsDataCommentsReplays $GetCommentNewsDataCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetCommentNewsDataCommentsReplays getCommentNewsDataCommentsReplays = GetCommentNewsDataCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCommentNewsDataCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCommentNewsDataCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCommentNewsDataCommentsReplays.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCommentNewsDataCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCommentNewsDataCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCommentNewsDataCommentsReplays.userimage = userimage;
  }
  final List<
      GetCommentNewsDataCommentsReplaysCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetCommentNewsDataCommentsReplaysCommentsReplays>(
          e) as GetCommentNewsDataCommentsReplaysCommentsReplays).toList();
  if (commentsReplays != null) {
    getCommentNewsDataCommentsReplays.commentsReplays = commentsReplays;
  }
  return getCommentNewsDataCommentsReplays;
}

Map<String, dynamic> $GetCommentNewsDataCommentsReplaysToJson(
    GetCommentNewsDataCommentsReplays entity) {
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

extension GetCommentNewsDataCommentsReplaysExtension on GetCommentNewsDataCommentsReplays {
  GetCommentNewsDataCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetCommentNewsDataCommentsReplaysCommentsReplays>? commentsReplays,
  }) {
    return GetCommentNewsDataCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetCommentNewsDataCommentsReplaysCommentsReplays $GetCommentNewsDataCommentsReplaysCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetCommentNewsDataCommentsReplaysCommentsReplays getCommentNewsDataCommentsReplaysCommentsReplays = GetCommentNewsDataCommentsReplaysCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCommentNewsDataCommentsReplaysCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCommentNewsDataCommentsReplaysCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCommentNewsDataCommentsReplaysCommentsReplays.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCommentNewsDataCommentsReplaysCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCommentNewsDataCommentsReplaysCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCommentNewsDataCommentsReplaysCommentsReplays.userimage = userimage;
  }
  final List<dynamic>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (commentsReplays != null) {
    getCommentNewsDataCommentsReplaysCommentsReplays.commentsReplays =
        commentsReplays;
  }
  return getCommentNewsDataCommentsReplaysCommentsReplays;
}

Map<String, dynamic> $GetCommentNewsDataCommentsReplaysCommentsReplaysToJson(
    GetCommentNewsDataCommentsReplaysCommentsReplays entity) {
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

extension GetCommentNewsDataCommentsReplaysCommentsReplaysExtension on GetCommentNewsDataCommentsReplaysCommentsReplays {
  GetCommentNewsDataCommentsReplaysCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<dynamic>? commentsReplays,
  }) {
    return GetCommentNewsDataCommentsReplaysCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}