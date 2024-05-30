import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_classified_entity.dart';

GetClassifiedEntity $GetClassifiedEntityFromJson(Map<String, dynamic> json) {
  final GetClassifiedEntity getClassifiedEntity = GetClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getClassifiedEntity.status = status;
  }
  final List<GetClassifiedData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetClassifiedData>(e) as GetClassifiedData)
      .toList();
  if (data != null) {
    getClassifiedEntity.data = data;
  }
  return getClassifiedEntity;
}

Map<String, dynamic> $GetClassifiedEntityToJson(GetClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetClassifiedEntityExtension on GetClassifiedEntity {
  GetClassifiedEntity copyWith({
    int? status,
    List<GetClassifiedData>? data,
  }) {
    return GetClassifiedEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetClassifiedData $GetClassifiedDataFromJson(Map<String, dynamic> json) {
  final GetClassifiedData getClassifiedData = GetClassifiedData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getClassifiedData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getClassifiedData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getClassifiedData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getClassifiedData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getClassifiedData.pgcnt = pgcnt;
  }
  final String? premiumsdate = jsonConvert.convert<String>(
      json['premiumsdate']);
  if (premiumsdate != null) {
    getClassifiedData.premiumsdate = premiumsdate;
  }
  final String? premiumedate = jsonConvert.convert<String>(
      json['premiumedate']);
  if (premiumedate != null) {
    getClassifiedData.premiumedate = premiumedate;
  }
  final String? popular = jsonConvert.convert<String>(json['popular']);
  if (popular != null) {
    getClassifiedData.popular = popular;
  }
  final dynamic user = json['user'];
  if (user != null) {
    getClassifiedData.user = user;
  }
  final int? totalLike = jsonConvert.convert<int>(json['total_like']);
  if (totalLike != null) {
    getClassifiedData.totalLike = totalLike;
  }
  final int? totalComment = jsonConvert.convert<int>(json['total_comment']);
  if (totalComment != null) {
    getClassifiedData.totalComment = totalComment;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getClassifiedData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getClassifiedData.imageThumPath = imageThumPath;
  }
  return getClassifiedData;
}

Map<String, dynamic> $GetClassifiedDataToJson(GetClassifiedData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['image'] = entity.image;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['premiumsdate'] = entity.premiumsdate;
  data['premiumedate'] = entity.premiumedate;
  data['popular'] = entity.popular;
  data['user'] = entity.user;
  data['total_like'] = entity.totalLike;
  data['total_comment'] = entity.totalComment;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetClassifiedDataExtension on GetClassifiedData {
  GetClassifiedData copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? pgcnt,
    String? premiumsdate,
    String? premiumedate,
    String? popular,
    dynamic user,
    int? totalLike,
    int? totalComment,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetClassifiedData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..premiumsdate = premiumsdate ?? this.premiumsdate
      ..premiumedate = premiumedate ?? this.premiumedate
      ..popular = popular ?? this.popular
      ..user = user ?? this.user
      ..totalLike = totalLike ?? this.totalLike
      ..totalComment = totalComment ?? this.totalComment
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}