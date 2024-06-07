import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/blog_like_list_entity.dart';

BlogLikeListEntity $BlogLikeListEntityFromJson(Map<String, dynamic> json) {
  final BlogLikeListEntity blogLikeListEntity = BlogLikeListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    blogLikeListEntity.status = status;
  }
  final List<BlogLikeListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<BlogLikeListData>(e) as BlogLikeListData)
      .toList();
  if (data != null) {
    blogLikeListEntity.data = data;
  }
  return blogLikeListEntity;
}

Map<String, dynamic> $BlogLikeListEntityToJson(BlogLikeListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension BlogLikeListEntityExtension on BlogLikeListEntity {
  BlogLikeListEntity copyWith({
    int? status,
    List<BlogLikeListData>? data,
  }) {
    return BlogLikeListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

BlogLikeListData $BlogLikeListDataFromJson(Map<String, dynamic> json) {
  final BlogLikeListData blogLikeListData = BlogLikeListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    blogLikeListData.id = id;
  }
  final int? bid = jsonConvert.convert<int>(json['bid']);
  if (bid != null) {
    blogLikeListData.bid = bid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    blogLikeListData.userid = userid;
  }
  final String? addeddate = jsonConvert.convert<String>(json['addeddate']);
  if (addeddate != null) {
    blogLikeListData.addeddate = addeddate;
  }
  final String? ipaddress = jsonConvert.convert<String>(json['ipaddress']);
  if (ipaddress != null) {
    blogLikeListData.ipaddress = ipaddress;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    blogLikeListData.type = type;
  }
  final String? ntype = jsonConvert.convert<String>(json['ntype']);
  if (ntype != null) {
    blogLikeListData.ntype = ntype;
  }
  final String? distype = jsonConvert.convert<String>(json['distype']);
  if (distype != null) {
    blogLikeListData.distype = distype;
  }
  final BlogLikeListDataUserData? userData = jsonConvert.convert<
      BlogLikeListDataUserData>(json['user_data']);
  if (userData != null) {
    blogLikeListData.userData = userData;
  }
  return blogLikeListData;
}

Map<String, dynamic> $BlogLikeListDataToJson(BlogLikeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['bid'] = entity.bid;
  data['userid'] = entity.userid;
  data['addeddate'] = entity.addeddate;
  data['ipaddress'] = entity.ipaddress;
  data['type'] = entity.type;
  data['ntype'] = entity.ntype;
  data['distype'] = entity.distype;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension BlogLikeListDataExtension on BlogLikeListData {
  BlogLikeListData copyWith({
    int? id,
    int? bid,
    int? userid,
    String? addeddate,
    String? ipaddress,
    String? type,
    String? ntype,
    String? distype,
    BlogLikeListDataUserData? userData,
  }) {
    return BlogLikeListData()
      ..id = id ?? this.id
      ..bid = bid ?? this.bid
      ..userid = userid ?? this.userid
      ..addeddate = addeddate ?? this.addeddate
      ..ipaddress = ipaddress ?? this.ipaddress
      ..type = type ?? this.type
      ..ntype = ntype ?? this.ntype
      ..distype = distype ?? this.distype
      ..userData = userData ?? this.userData;
  }
}

BlogLikeListDataUserData $BlogLikeListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final BlogLikeListDataUserData blogLikeListDataUserData = BlogLikeListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    blogLikeListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    blogLikeListDataUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    blogLikeListDataUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    blogLikeListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    blogLikeListDataUserData.imageThumPath = imageThumPath;
  }
  return blogLikeListDataUserData;
}

Map<String, dynamic> $BlogLikeListDataUserDataToJson(
    BlogLikeListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension BlogLikeListDataUserDataExtension on BlogLikeListDataUserData {
  BlogLikeListDataUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return BlogLikeListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}