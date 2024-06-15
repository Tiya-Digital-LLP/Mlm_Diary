import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_comment_classified_entity.dart';

GetCommentClassifiedEntity $GetCommentClassifiedEntityFromJson(
    Map<String, dynamic> json) {
  final GetCommentClassifiedEntity getCommentClassifiedEntity = GetCommentClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getCommentClassifiedEntity.status = status;
  }
  final List<GetCommentClassifiedData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetCommentClassifiedData>(
          e) as GetCommentClassifiedData)
      .toList();
  if (data != null) {
    getCommentClassifiedEntity.data = data;
  }
  return getCommentClassifiedEntity;
}

Map<String, dynamic> $GetCommentClassifiedEntityToJson(
    GetCommentClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetCommentClassifiedEntityExtension on GetCommentClassifiedEntity {
  GetCommentClassifiedEntity copyWith({
    int? status,
    List<GetCommentClassifiedData>? data,
  }) {
    return GetCommentClassifiedEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetCommentClassifiedData $GetCommentClassifiedDataFromJson(
    Map<String, dynamic> json) {
  final GetCommentClassifiedData getCommentClassifiedData = GetCommentClassifiedData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCommentClassifiedData.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCommentClassifiedData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCommentClassifiedData.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCommentClassifiedData.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCommentClassifiedData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCommentClassifiedData.userimage = userimage;
  }
  final List<
      GetCommentClassifiedDataCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetCommentClassifiedDataCommentsReplays>(
          e) as GetCommentClassifiedDataCommentsReplays).toList();
  if (commentsReplays != null) {
    getCommentClassifiedData.commentsReplays = commentsReplays;
  }
  return getCommentClassifiedData;
}

Map<String, dynamic> $GetCommentClassifiedDataToJson(
    GetCommentClassifiedData entity) {
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

extension GetCommentClassifiedDataExtension on GetCommentClassifiedData {
  GetCommentClassifiedData copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetCommentClassifiedDataCommentsReplays>? commentsReplays,
  }) {
    return GetCommentClassifiedData()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetCommentClassifiedDataCommentsReplays $GetCommentClassifiedDataCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetCommentClassifiedDataCommentsReplays getCommentClassifiedDataCommentsReplays = GetCommentClassifiedDataCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCommentClassifiedDataCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCommentClassifiedDataCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCommentClassifiedDataCommentsReplays.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCommentClassifiedDataCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCommentClassifiedDataCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCommentClassifiedDataCommentsReplays.userimage = userimage;
  }
  return getCommentClassifiedDataCommentsReplays;
}

Map<String, dynamic> $GetCommentClassifiedDataCommentsReplaysToJson(
    GetCommentClassifiedDataCommentsReplays entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  return data;
}

extension GetCommentClassifiedDataCommentsReplaysExtension on GetCommentClassifiedDataCommentsReplays {
  GetCommentClassifiedDataCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
  }) {
    return GetCommentClassifiedDataCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage;
  }
}