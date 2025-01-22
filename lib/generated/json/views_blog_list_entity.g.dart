import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/views_blog_list_entity.dart';

ViewsBlogListEntity $ViewsBlogListEntityFromJson(Map<String, dynamic> json) {
  final ViewsBlogListEntity viewsBlogListEntity = ViewsBlogListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    viewsBlogListEntity.status = status;
  }
  final List<ViewsBlogListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ViewsBlogListData>(e) as ViewsBlogListData)
      .toList();
  if (data != null) {
    viewsBlogListEntity.data = data;
  }
  return viewsBlogListEntity;
}

Map<String, dynamic> $ViewsBlogListEntityToJson(ViewsBlogListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ViewsBlogListEntityExtension on ViewsBlogListEntity {
  ViewsBlogListEntity copyWith({
    int? status,
    List<ViewsBlogListData>? data,
  }) {
    return ViewsBlogListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ViewsBlogListData $ViewsBlogListDataFromJson(Map<String, dynamic> json) {
  final ViewsBlogListData viewsBlogListData = ViewsBlogListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewsBlogListData.id = id;
  }
  final int? bid = jsonConvert.convert<int>(json['bid']);
  if (bid != null) {
    viewsBlogListData.bid = bid;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    viewsBlogListData.userId = userId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    viewsBlogListData.createdAt = createdAt;
  }
  final ViewsBlogListDataUserData? userData = jsonConvert.convert<
      ViewsBlogListDataUserData>(json['user_data']);
  if (userData != null) {
    viewsBlogListData.userData = userData;
  }
  return viewsBlogListData;
}

Map<String, dynamic> $ViewsBlogListDataToJson(ViewsBlogListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['bid'] = entity.bid;
  data['user_id'] = entity.userId;
  data['created_at'] = entity.createdAt;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension ViewsBlogListDataExtension on ViewsBlogListData {
  ViewsBlogListData copyWith({
    int? id,
    int? bid,
    int? userId,
    String? createdAt,
    ViewsBlogListDataUserData? userData,
  }) {
    return ViewsBlogListData()
      ..id = id ?? this.id
      ..bid = bid ?? this.bid
      ..userId = userId ?? this.userId
      ..createdAt = createdAt ?? this.createdAt
      ..userData = userData ?? this.userData;
  }
}

ViewsBlogListDataUserData $ViewsBlogListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ViewsBlogListDataUserData viewsBlogListDataUserData = ViewsBlogListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    viewsBlogListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    viewsBlogListDataUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewsBlogListDataUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    viewsBlogListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    viewsBlogListDataUserData.imageThumPath = imageThumPath;
  }
  return viewsBlogListDataUserData;
}

Map<String, dynamic> $ViewsBlogListDataUserDataToJson(
    ViewsBlogListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension ViewsBlogListDataUserDataExtension on ViewsBlogListDataUserData {
  ViewsBlogListDataUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ViewsBlogListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}