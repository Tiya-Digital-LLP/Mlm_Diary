import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_blog_comment_entity.dart';

GetBlogCommentEntity $GetBlogCommentEntityFromJson(Map<String, dynamic> json) {
  final GetBlogCommentEntity getBlogCommentEntity = GetBlogCommentEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getBlogCommentEntity.status = status;
  }
  final List<GetBlogCommentData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetBlogCommentData>(e) as GetBlogCommentData)
      .toList();
  if (data != null) {
    getBlogCommentEntity.data = data;
  }
  return getBlogCommentEntity;
}

Map<String, dynamic> $GetBlogCommentEntityToJson(GetBlogCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetBlogCommentEntityExtension on GetBlogCommentEntity {
  GetBlogCommentEntity copyWith({
    int? status,
    List<GetBlogCommentData>? data,
  }) {
    return GetBlogCommentEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetBlogCommentData $GetBlogCommentDataFromJson(Map<String, dynamic> json) {
  final GetBlogCommentData getBlogCommentData = GetBlogCommentData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogCommentData.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getBlogCommentData.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getBlogCommentData.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getBlogCommentData.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getBlogCommentData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getBlogCommentData.userimage = userimage;
  }
  final List<
      GetBlogCommentDataCommentsReplays>? commentsReplays = (json['comments_replays'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetBlogCommentDataCommentsReplays>(
          e) as GetBlogCommentDataCommentsReplays).toList();
  if (commentsReplays != null) {
    getBlogCommentData.commentsReplays = commentsReplays;
  }
  return getBlogCommentData;
}

Map<String, dynamic> $GetBlogCommentDataToJson(GetBlogCommentData entity) {
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

extension GetBlogCommentDataExtension on GetBlogCommentData {
  GetBlogCommentData copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetBlogCommentDataCommentsReplays>? commentsReplays,
  }) {
    return GetBlogCommentData()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..commentsReplays = commentsReplays ?? this.commentsReplays;
  }
}

GetBlogCommentDataCommentsReplays $GetBlogCommentDataCommentsReplaysFromJson(
    Map<String, dynamic> json) {
  final GetBlogCommentDataCommentsReplays getBlogCommentDataCommentsReplays = GetBlogCommentDataCommentsReplays();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogCommentDataCommentsReplays.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getBlogCommentDataCommentsReplays.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getBlogCommentDataCommentsReplays.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getBlogCommentDataCommentsReplays.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getBlogCommentDataCommentsReplays.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getBlogCommentDataCommentsReplays.userimage = userimage;
  }
  return getBlogCommentDataCommentsReplays;
}

Map<String, dynamic> $GetBlogCommentDataCommentsReplaysToJson(
    GetBlogCommentDataCommentsReplays entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  return data;
}

extension GetBlogCommentDataCommentsReplaysExtension on GetBlogCommentDataCommentsReplays {
  GetBlogCommentDataCommentsReplays copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
  }) {
    return GetBlogCommentDataCommentsReplays()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage;
  }
}