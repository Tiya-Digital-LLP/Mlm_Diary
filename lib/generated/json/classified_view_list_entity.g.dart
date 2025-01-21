import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/classified_view_list_entity.dart';

ClassifiedViewListEntity $ClassifiedViewListEntityFromJson(
    Map<String, dynamic> json) {
  final ClassifiedViewListEntity classifiedViewListEntity = ClassifiedViewListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    classifiedViewListEntity.status = status;
  }
  final List<ClassifiedViewListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ClassifiedViewListData>(e) as ClassifiedViewListData)
      .toList();
  if (data != null) {
    classifiedViewListEntity.data = data;
  }
  return classifiedViewListEntity;
}

Map<String, dynamic> $ClassifiedViewListEntityToJson(
    ClassifiedViewListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ClassifiedViewListEntityExtension on ClassifiedViewListEntity {
  ClassifiedViewListEntity copyWith({
    int? status,
    List<ClassifiedViewListData>? data,
  }) {
    return ClassifiedViewListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ClassifiedViewListData $ClassifiedViewListDataFromJson(
    Map<String, dynamic> json) {
  final ClassifiedViewListData classifiedViewListData = ClassifiedViewListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    classifiedViewListData.id = id;
  }
  final int? cid = jsonConvert.convert<int>(json['cid']);
  if (cid != null) {
    classifiedViewListData.cid = cid;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    classifiedViewListData.userId = userId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    classifiedViewListData.createdAt = createdAt;
  }
  final ClassifiedViewListDataUserData? userData = jsonConvert.convert<
      ClassifiedViewListDataUserData>(json['user_data']);
  if (userData != null) {
    classifiedViewListData.userData = userData;
  }
  return classifiedViewListData;
}

Map<String, dynamic> $ClassifiedViewListDataToJson(
    ClassifiedViewListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['cid'] = entity.cid;
  data['user_id'] = entity.userId;
  data['created_at'] = entity.createdAt;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension ClassifiedViewListDataExtension on ClassifiedViewListData {
  ClassifiedViewListData copyWith({
    int? id,
    int? cid,
    int? userId,
    String? createdAt,
    ClassifiedViewListDataUserData? userData,
  }) {
    return ClassifiedViewListData()
      ..id = id ?? this.id
      ..cid = cid ?? this.cid
      ..userId = userId ?? this.userId
      ..createdAt = createdAt ?? this.createdAt
      ..userData = userData ?? this.userData;
  }
}

ClassifiedViewListDataUserData $ClassifiedViewListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ClassifiedViewListDataUserData classifiedViewListDataUserData = ClassifiedViewListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    classifiedViewListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    classifiedViewListDataUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    classifiedViewListDataUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    classifiedViewListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    classifiedViewListDataUserData.imageThumPath = imageThumPath;
  }
  return classifiedViewListDataUserData;
}

Map<String, dynamic> $ClassifiedViewListDataUserDataToJson(
    ClassifiedViewListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension ClassifiedViewListDataUserDataExtension on ClassifiedViewListDataUserData {
  ClassifiedViewListDataUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ClassifiedViewListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}