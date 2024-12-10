import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/news_like_list_entity.dart';

NewsLikeListEntity $NewsLikeListEntityFromJson(Map<String, dynamic> json) {
  final NewsLikeListEntity newsLikeListEntity = NewsLikeListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    newsLikeListEntity.status = status;
  }
  final List<NewsLikeListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<NewsLikeListData>(e) as NewsLikeListData)
      .toList();
  if (data != null) {
    newsLikeListEntity.data = data;
  }
  return newsLikeListEntity;
}

Map<String, dynamic> $NewsLikeListEntityToJson(NewsLikeListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension NewsLikeListEntityExtension on NewsLikeListEntity {
  NewsLikeListEntity copyWith({
    int? status,
    List<NewsLikeListData>? data,
  }) {
    return NewsLikeListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

NewsLikeListData $NewsLikeListDataFromJson(Map<String, dynamic> json) {
  final NewsLikeListData newsLikeListData = NewsLikeListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    newsLikeListData.id = id;
  }
  final int? nid = jsonConvert.convert<int>(json['nid']);
  if (nid != null) {
    newsLikeListData.nid = nid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    newsLikeListData.userid = userid;
  }
  final String? addeddate = jsonConvert.convert<String>(json['addeddate']);
  if (addeddate != null) {
    newsLikeListData.addeddate = addeddate;
  }
  final String? ipaddress = jsonConvert.convert<String>(json['ipaddress']);
  if (ipaddress != null) {
    newsLikeListData.ipaddress = ipaddress;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    newsLikeListData.type = type;
  }
  final String? ntype = jsonConvert.convert<String>(json['ntype']);
  if (ntype != null) {
    newsLikeListData.ntype = ntype;
  }
  final String? distype = jsonConvert.convert<String>(json['distype']);
  if (distype != null) {
    newsLikeListData.distype = distype;
  }
  final NewsLikeListDataUserData? userData = jsonConvert.convert<
      NewsLikeListDataUserData>(json['user_data']);
  if (userData != null) {
    newsLikeListData.userData = userData;
  }
  return newsLikeListData;
}

Map<String, dynamic> $NewsLikeListDataToJson(NewsLikeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['nid'] = entity.nid;
  data['userid'] = entity.userid;
  data['addeddate'] = entity.addeddate;
  data['ipaddress'] = entity.ipaddress;
  data['type'] = entity.type;
  data['ntype'] = entity.ntype;
  data['distype'] = entity.distype;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension NewsLikeListDataExtension on NewsLikeListData {
  NewsLikeListData copyWith({
    int? id,
    int? nid,
    int? userid,
    String? addeddate,
    String? ipaddress,
    String? type,
    String? ntype,
    String? distype,
    NewsLikeListDataUserData? userData,
  }) {
    return NewsLikeListData()
      ..id = id ?? this.id
      ..nid = nid ?? this.nid
      ..userid = userid ?? this.userid
      ..addeddate = addeddate ?? this.addeddate
      ..ipaddress = ipaddress ?? this.ipaddress
      ..type = type ?? this.type
      ..ntype = ntype ?? this.ntype
      ..distype = distype ?? this.distype
      ..userData = userData ?? this.userData;
  }
}

NewsLikeListDataUserData $NewsLikeListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final NewsLikeListDataUserData newsLikeListDataUserData = NewsLikeListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    newsLikeListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    newsLikeListDataUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    newsLikeListDataUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    newsLikeListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    newsLikeListDataUserData.imageThumPath = imageThumPath;
  }
  return newsLikeListDataUserData;
}

Map<String, dynamic> $NewsLikeListDataUserDataToJson(
    NewsLikeListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension NewsLikeListDataUserDataExtension on NewsLikeListDataUserData {
  NewsLikeListDataUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return NewsLikeListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}