import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/view_company_list_entity.dart';

ViewCompanyListEntity $ViewCompanyListEntityFromJson(
    Map<String, dynamic> json) {
  final ViewCompanyListEntity viewCompanyListEntity = ViewCompanyListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    viewCompanyListEntity.status = status;
  }
  final List<ViewCompanyListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ViewCompanyListData>(e) as ViewCompanyListData)
      .toList();
  if (data != null) {
    viewCompanyListEntity.data = data;
  }
  return viewCompanyListEntity;
}

Map<String, dynamic> $ViewCompanyListEntityToJson(
    ViewCompanyListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ViewCompanyListEntityExtension on ViewCompanyListEntity {
  ViewCompanyListEntity copyWith({
    int? status,
    List<ViewCompanyListData>? data,
  }) {
    return ViewCompanyListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ViewCompanyListData $ViewCompanyListDataFromJson(Map<String, dynamic> json) {
  final ViewCompanyListData viewCompanyListData = ViewCompanyListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewCompanyListData.id = id;
  }
  final int? cid = jsonConvert.convert<int>(json['cid']);
  if (cid != null) {
    viewCompanyListData.cid = cid;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    viewCompanyListData.userId = userId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    viewCompanyListData.createdAt = createdAt;
  }
  final ViewCompanyListDataUserData? userData = jsonConvert.convert<
      ViewCompanyListDataUserData>(json['user_data']);
  if (userData != null) {
    viewCompanyListData.userData = userData;
  }
  return viewCompanyListData;
}

Map<String, dynamic> $ViewCompanyListDataToJson(ViewCompanyListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['cid'] = entity.cid;
  data['user_id'] = entity.userId;
  data['created_at'] = entity.createdAt;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension ViewCompanyListDataExtension on ViewCompanyListData {
  ViewCompanyListData copyWith({
    int? id,
    int? cid,
    int? userId,
    String? createdAt,
    ViewCompanyListDataUserData? userData,
  }) {
    return ViewCompanyListData()
      ..id = id ?? this.id
      ..cid = cid ?? this.cid
      ..userId = userId ?? this.userId
      ..createdAt = createdAt ?? this.createdAt
      ..userData = userData ?? this.userData;
  }
}

ViewCompanyListDataUserData $ViewCompanyListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ViewCompanyListDataUserData viewCompanyListDataUserData = ViewCompanyListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewCompanyListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    viewCompanyListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    viewCompanyListDataUserData.userimage = userimage;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    viewCompanyListDataUserData.immlm = immlm;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    viewCompanyListDataUserData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    viewCompanyListDataUserData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    viewCompanyListDataUserData.country = country;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    viewCompanyListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    viewCompanyListDataUserData.imageThumPath = imageThumPath;
  }
  return viewCompanyListDataUserData;
}

Map<String, dynamic> $ViewCompanyListDataUserDataToJson(
    ViewCompanyListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['immlm'] = entity.immlm;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension ViewCompanyListDataUserDataExtension on ViewCompanyListDataUserData {
  ViewCompanyListDataUserData copyWith({
    int? id,
    String? name,
    String? userimage,
    String? immlm,
    String? city,
    String? state,
    String? country,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ViewCompanyListDataUserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..immlm = immlm ?? this.immlm
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}