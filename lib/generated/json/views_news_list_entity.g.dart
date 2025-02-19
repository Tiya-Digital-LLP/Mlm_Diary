import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/views_news_list_entity.dart';

ViewsNewsListEntity $ViewsNewsListEntityFromJson(Map<String, dynamic> json) {
  final ViewsNewsListEntity viewsNewsListEntity = ViewsNewsListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    viewsNewsListEntity.status = status;
  }
  final List<ViewsNewsListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ViewsNewsListData>(e) as ViewsNewsListData)
      .toList();
  if (data != null) {
    viewsNewsListEntity.data = data;
  }
  return viewsNewsListEntity;
}

Map<String, dynamic> $ViewsNewsListEntityToJson(ViewsNewsListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ViewsNewsListEntityExtension on ViewsNewsListEntity {
  ViewsNewsListEntity copyWith({
    int? status,
    List<ViewsNewsListData>? data,
  }) {
    return ViewsNewsListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ViewsNewsListData $ViewsNewsListDataFromJson(Map<String, dynamic> json) {
  final ViewsNewsListData viewsNewsListData = ViewsNewsListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewsNewsListData.id = id;
  }
  final int? nid = jsonConvert.convert<int>(json['nid']);
  if (nid != null) {
    viewsNewsListData.nid = nid;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    viewsNewsListData.userId = userId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    viewsNewsListData.createdAt = createdAt;
  }
  final ViewsNewsListDataUserData? userData = jsonConvert.convert<
      ViewsNewsListDataUserData>(json['user_data']);
  if (userData != null) {
    viewsNewsListData.userData = userData;
  }
  return viewsNewsListData;
}

Map<String, dynamic> $ViewsNewsListDataToJson(ViewsNewsListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['nid'] = entity.nid;
  data['user_id'] = entity.userId;
  data['created_at'] = entity.createdAt;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension ViewsNewsListDataExtension on ViewsNewsListData {
  ViewsNewsListData copyWith({
    int? id,
    int? nid,
    int? userId,
    String? createdAt,
    ViewsNewsListDataUserData? userData,
  }) {
    return ViewsNewsListData()
      ..id = id ?? this.id
      ..nid = nid ?? this.nid
      ..userId = userId ?? this.userId
      ..createdAt = createdAt ?? this.createdAt
      ..userData = userData ?? this.userData;
  }
}

ViewsNewsListDataUserData $ViewsNewsListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ViewsNewsListDataUserData viewsNewsListDataUserData = ViewsNewsListDataUserData();
  final dynamic id = json['id'];
  if (id != null) {
    viewsNewsListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    viewsNewsListDataUserData.name = name;
  }
  final dynamic userimage = json['userimage'];
  if (userimage != null) {
    viewsNewsListDataUserData.userimage = userimage;
  }
  final dynamic imagePath = json['image_path'];
  if (imagePath != null) {
    viewsNewsListDataUserData.imagePath = imagePath;
  }
  final dynamic immlm = json['immlm'];
  if (immlm != null) {
    viewsNewsListDataUserData.immlm = immlm;
  }
  final dynamic city = json['city'];
  if (city != null) {
    viewsNewsListDataUserData.city = city;
  }
  final dynamic state = json['state'];
  if (state != null) {
    viewsNewsListDataUserData.state = state;
  }
  final dynamic country = json['country'];
  if (country != null) {
    viewsNewsListDataUserData.country = country;
  }
  return viewsNewsListDataUserData;
}

Map<String, dynamic> $ViewsNewsListDataUserDataToJson(
    ViewsNewsListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['image_path'] = entity.imagePath;
  data['immlm'] = entity.immlm;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  return data;
}

extension ViewsNewsListDataUserDataExtension on ViewsNewsListDataUserData {
  ViewsNewsListDataUserData copyWith({
    dynamic id,
    String? name,
    dynamic userimage,
    dynamic imagePath,
    dynamic immlm,
    dynamic city,
    dynamic state,
    dynamic country,
  }) {
    return ViewsNewsListDataUserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..imagePath = imagePath ?? this.imagePath
      ..immlm = immlm ?? this.immlm
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country;
  }
}