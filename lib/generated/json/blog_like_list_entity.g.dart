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
  final int? nid = jsonConvert.convert<int>(json['nid']);
  if (nid != null) {
    blogLikeListData.nid = nid;
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
  final dynamic distype = json['distype'];
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

extension BlogLikeListDataExtension on BlogLikeListData {
  BlogLikeListData copyWith({
    int? id,
    int? nid,
    int? userid,
    String? addeddate,
    String? ipaddress,
    String? type,
    String? ntype,
    dynamic distype,
    BlogLikeListDataUserData? userData,
  }) {
    return BlogLikeListData()
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

BlogLikeListDataUserData $BlogLikeListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final BlogLikeListDataUserData blogLikeListDataUserData = BlogLikeListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    blogLikeListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    blogLikeListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    blogLikeListDataUserData.userimage = userimage;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    blogLikeListDataUserData.immlm = immlm;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    blogLikeListDataUserData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    blogLikeListDataUserData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    blogLikeListDataUserData.country = country;
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

extension BlogLikeListDataUserDataExtension on BlogLikeListDataUserData {
  BlogLikeListDataUserData copyWith({
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
    return BlogLikeListDataUserData()
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