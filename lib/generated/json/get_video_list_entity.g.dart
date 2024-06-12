import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_video_list_entity.dart';

GetVideoListEntity $GetVideoListEntityFromJson(Map<String, dynamic> json) {
  final GetVideoListEntity getVideoListEntity = GetVideoListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getVideoListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getVideoListEntity.message = message;
  }
  final List<GetVideoListVideos>? videos = (json['videos'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetVideoListVideos>(e) as GetVideoListVideos)
      .toList();
  if (videos != null) {
    getVideoListEntity.videos = videos;
  }
  return getVideoListEntity;
}

Map<String, dynamic> $GetVideoListEntityToJson(GetVideoListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['videos'] = entity.videos?.map((v) => v.toJson()).toList();
  return data;
}

extension GetVideoListEntityExtension on GetVideoListEntity {
  GetVideoListEntity copyWith({
    int? status,
    String? message,
    List<GetVideoListVideos>? videos,
  }) {
    return GetVideoListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..videos = videos ?? this.videos;
  }
}

GetVideoListVideos $GetVideoListVideosFromJson(Map<String, dynamic> json) {
  final GetVideoListVideos getVideoListVideos = GetVideoListVideos();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getVideoListVideos.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getVideoListVideos.title = title;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getVideoListVideos.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getVideoListVideos.subcategory = subcategory;
  }
  final String? userid = jsonConvert.convert<String>(json['userid']);
  if (userid != null) {
    getVideoListVideos.userid = userid;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getVideoListVideos.image = image;
  }
  final String? caption = jsonConvert.convert<String>(json['caption']);
  if (caption != null) {
    getVideoListVideos.caption = caption;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getVideoListVideos.description = description;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getVideoListVideos.createdate = createdate;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getVideoListVideos.pgcnt = pgcnt;
  }
  final dynamic datemodified = json['datemodified'];
  if (datemodified != null) {
    getVideoListVideos.datemodified = datemodified;
  }
  final bool? isBookmark = jsonConvert.convert<bool>(json['is_bookmark']);
  if (isBookmark != null) {
    getVideoListVideos.isBookmark = isBookmark;
  }
  return getVideoListVideos;
}

Map<String, dynamic> $GetVideoListVideosToJson(GetVideoListVideos entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['category'] = entity.category;
  data['subcategory'] = entity.subcategory;
  data['userid'] = entity.userid;
  data['image'] = entity.image;
  data['caption'] = entity.caption;
  data['description'] = entity.description;
  data['createdate'] = entity.createdate;
  data['pgcnt'] = entity.pgcnt;
  data['datemodified'] = entity.datemodified;
  data['is_bookmark'] = entity.isBookmark;
  return data;
}

extension GetVideoListVideosExtension on GetVideoListVideos {
  GetVideoListVideos copyWith({
    int? id,
    String? title,
    String? category,
    String? subcategory,
    String? userid,
    String? image,
    String? caption,
    String? description,
    String? createdate,
    int? pgcnt,
    dynamic datemodified,
    bool? isBookmark,
  }) {
    return GetVideoListVideos()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..category = category ?? this.category
      ..subcategory = subcategory ?? this.subcategory
      ..userid = userid ?? this.userid
      ..image = image ?? this.image
      ..caption = caption ?? this.caption
      ..description = description ?? this.description
      ..createdate = createdate ?? this.createdate
      ..pgcnt = pgcnt ?? this.pgcnt
      ..datemodified = datemodified ?? this.datemodified
      ..isBookmark = isBookmark ?? this.isBookmark;
  }
}