import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_company_comment_entity.dart';

GetCompanyCommentEntity $GetCompanyCommentEntityFromJson(
    Map<String, dynamic> json) {
  final GetCompanyCommentEntity getCompanyCommentEntity = GetCompanyCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getCompanyCommentEntity.status = status;
  }
  final List<GetCompanyCommentData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetCompanyCommentData>(e) as GetCompanyCommentData)
      .toList();
  if (data != null) {
    getCompanyCommentEntity.data = data;
  }
  return getCompanyCommentEntity;
}

Map<String, dynamic> $GetCompanyCommentEntityToJson(
    GetCompanyCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetCompanyCommentEntityExtension on GetCompanyCommentEntity {
  GetCompanyCommentEntity copyWith({
    int? status,
    List<GetCompanyCommentData>? data,
  }) {
    return GetCompanyCommentEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetCompanyCommentData $GetCompanyCommentDataFromJson(
    Map<String, dynamic> json) {
  final GetCompanyCommentData getCompanyCommentData = GetCompanyCommentData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCompanyCommentData.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCompanyCommentData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCompanyCommentData.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCompanyCommentData.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCompanyCommentData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCompanyCommentData.userimage = userimage;
  }
  final List<
      GetCompanyCommentDataCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetCompanyCommentDataCommentsReplays>(
          e) as GetCompanyCommentDataCommentsReplays).toList();
  if (commentsReplays != null) {
    getCompanyCommentData.commentsReplays = commentsReplays;
  }
  return getCompanyCommentData;
}

Map<String, dynamic> $GetCompanyCommentDataToJson(
    GetCompanyCommentData entity) {
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

extension GetCompanyCommentDataExtension on GetCompanyCommentData {
  GetCompanyCommentData copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetCompanyCommentDataCommentsReplays>? commentsReplays,
  }) {
    return GetCompanyCommentData()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetCompanyCommentDataCommentsReplays $GetCompanyCommentDataCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetCompanyCommentDataCommentsReplays getCompanyCommentDataCommentsReplays = GetCompanyCommentDataCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCompanyCommentDataCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCompanyCommentDataCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCompanyCommentDataCommentsReplays.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCompanyCommentDataCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCompanyCommentDataCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCompanyCommentDataCommentsReplays.userimage = userimage;
  }
  final List<
      GetCompanyCommentDataCommentsReplaysCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetCompanyCommentDataCommentsReplaysCommentsReplays>(
          e) as GetCompanyCommentDataCommentsReplaysCommentsReplays).toList();
  if (commentsReplays != null) {
    getCompanyCommentDataCommentsReplays.commentsReplays = commentsReplays;
  }
  return getCompanyCommentDataCommentsReplays;
}

Map<String, dynamic> $GetCompanyCommentDataCommentsReplaysToJson(
    GetCompanyCommentDataCommentsReplays entity) {
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

extension GetCompanyCommentDataCommentsReplaysExtension on GetCompanyCommentDataCommentsReplays {
  GetCompanyCommentDataCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetCompanyCommentDataCommentsReplaysCommentsReplays>? commentsReplays,
  }) {
    return GetCompanyCommentDataCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetCompanyCommentDataCommentsReplaysCommentsReplays $GetCompanyCommentDataCommentsReplaysCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetCompanyCommentDataCommentsReplaysCommentsReplays getCompanyCommentDataCommentsReplaysCommentsReplays = GetCompanyCommentDataCommentsReplaysCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCompanyCommentDataCommentsReplaysCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getCompanyCommentDataCommentsReplaysCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getCompanyCommentDataCommentsReplaysCommentsReplays.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getCompanyCommentDataCommentsReplaysCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCompanyCommentDataCommentsReplaysCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getCompanyCommentDataCommentsReplaysCommentsReplays.userimage = userimage;
  }
  final List<dynamic>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (commentsReplays != null) {
    getCompanyCommentDataCommentsReplaysCommentsReplays.commentsReplays =
        commentsReplays;
  }
  return getCompanyCommentDataCommentsReplaysCommentsReplays;
}

Map<String, dynamic> $GetCompanyCommentDataCommentsReplaysCommentsReplaysToJson(
    GetCompanyCommentDataCommentsReplaysCommentsReplays entity) {
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

extension GetCompanyCommentDataCommentsReplaysCommentsReplaysExtension on GetCompanyCommentDataCommentsReplaysCommentsReplays {
  GetCompanyCommentDataCommentsReplaysCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<dynamic>? commentsReplays,
  }) {
    return GetCompanyCommentDataCommentsReplaysCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}