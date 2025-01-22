import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/view_post_list_entity.dart';

ViewPostListEntity $ViewPostListEntityFromJson(Map<String, dynamic> json) {
  final ViewPostListEntity viewPostListEntity = ViewPostListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    viewPostListEntity.status = status;
  }
  final List<ViewPostListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ViewPostListData>(e) as ViewPostListData)
      .toList();
  if (data != null) {
    viewPostListEntity.data = data;
  }
  return viewPostListEntity;
}

Map<String, dynamic> $ViewPostListEntityToJson(ViewPostListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ViewPostListEntityExtension on ViewPostListEntity {
  ViewPostListEntity copyWith({
    int? status,
    List<ViewPostListData>? data,
  }) {
    return ViewPostListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ViewPostListData $ViewPostListDataFromJson(Map<String, dynamic> json) {
  final ViewPostListData viewPostListData = ViewPostListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewPostListData.id = id;
  }
  final int? pid = jsonConvert.convert<int>(json['pid']);
  if (pid != null) {
    viewPostListData.pid = pid;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    viewPostListData.userId = userId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    viewPostListData.createdAt = createdAt;
  }
  final ViewPostListDataUserData? userData = jsonConvert.convert<
      ViewPostListDataUserData>(json['user_data']);
  if (userData != null) {
    viewPostListData.userData = userData;
  }
  return viewPostListData;
}

Map<String, dynamic> $ViewPostListDataToJson(ViewPostListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['pid'] = entity.pid;
  data['user_id'] = entity.userId;
  data['created_at'] = entity.createdAt;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension ViewPostListDataExtension on ViewPostListData {
  ViewPostListData copyWith({
    int? id,
    int? pid,
    int? userId,
    String? createdAt,
    ViewPostListDataUserData? userData,
  }) {
    return ViewPostListData()
      ..id = id ?? this.id
      ..pid = pid ?? this.pid
      ..userId = userId ?? this.userId
      ..createdAt = createdAt ?? this.createdAt
      ..userData = userData ?? this.userData;
  }
}

ViewPostListDataUserData $ViewPostListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ViewPostListDataUserData viewPostListDataUserData = ViewPostListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    viewPostListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    viewPostListDataUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewPostListDataUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    viewPostListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    viewPostListDataUserData.imageThumPath = imageThumPath;
  }
  return viewPostListDataUserData;
}

Map<String, dynamic> $ViewPostListDataUserDataToJson(
    ViewPostListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension ViewPostListDataUserDataExtension on ViewPostListDataUserData {
  ViewPostListDataUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ViewPostListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}