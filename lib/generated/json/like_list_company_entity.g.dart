import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/like_list_company_entity.dart';

LikeListCompanyEntity $LikeListCompanyEntityFromJson(
    Map<String, dynamic> json) {
  final LikeListCompanyEntity likeListCompanyEntity = LikeListCompanyEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    likeListCompanyEntity.status = status;
  }
  final List<LikeListCompanyData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<LikeListCompanyData>(e) as LikeListCompanyData)
      .toList();
  if (data != null) {
    likeListCompanyEntity.data = data;
  }
  return likeListCompanyEntity;
}

Map<String, dynamic> $LikeListCompanyEntityToJson(
    LikeListCompanyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension LikeListCompanyEntityExtension on LikeListCompanyEntity {
  LikeListCompanyEntity copyWith({
    int? status,
    List<LikeListCompanyData>? data,
  }) {
    return LikeListCompanyEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

LikeListCompanyData $LikeListCompanyDataFromJson(Map<String, dynamic> json) {
  final LikeListCompanyData likeListCompanyData = LikeListCompanyData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    likeListCompanyData.id = id;
  }
  final int? oid = jsonConvert.convert<int>(json['oid']);
  if (oid != null) {
    likeListCompanyData.oid = oid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    likeListCompanyData.userid = userid;
  }
  final String? addeddate = jsonConvert.convert<String>(json['addeddate']);
  if (addeddate != null) {
    likeListCompanyData.addeddate = addeddate;
  }
  final String? ipaddress = jsonConvert.convert<String>(json['ipaddress']);
  if (ipaddress != null) {
    likeListCompanyData.ipaddress = ipaddress;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    likeListCompanyData.type = type;
  }
  final String? ntype = jsonConvert.convert<String>(json['ntype']);
  if (ntype != null) {
    likeListCompanyData.ntype = ntype;
  }
  final String? distype = jsonConvert.convert<String>(json['distype']);
  if (distype != null) {
    likeListCompanyData.distype = distype;
  }
  final LikeListCompanyDataUserData? userData = jsonConvert.convert<
      LikeListCompanyDataUserData>(json['user_data']);
  if (userData != null) {
    likeListCompanyData.userData = userData;
  }
  return likeListCompanyData;
}

Map<String, dynamic> $LikeListCompanyDataToJson(LikeListCompanyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['oid'] = entity.oid;
  data['userid'] = entity.userid;
  data['addeddate'] = entity.addeddate;
  data['ipaddress'] = entity.ipaddress;
  data['type'] = entity.type;
  data['ntype'] = entity.ntype;
  data['distype'] = entity.distype;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension LikeListCompanyDataExtension on LikeListCompanyData {
  LikeListCompanyData copyWith({
    int? id,
    int? oid,
    int? userid,
    String? addeddate,
    String? ipaddress,
    String? type,
    String? ntype,
    String? distype,
    LikeListCompanyDataUserData? userData,
  }) {
    return LikeListCompanyData()
      ..id = id ?? this.id
      ..oid = oid ?? this.oid
      ..userid = userid ?? this.userid
      ..addeddate = addeddate ?? this.addeddate
      ..ipaddress = ipaddress ?? this.ipaddress
      ..type = type ?? this.type
      ..ntype = ntype ?? this.ntype
      ..distype = distype ?? this.distype
      ..userData = userData ?? this.userData;
  }
}

LikeListCompanyDataUserData $LikeListCompanyDataUserDataFromJson(
    Map<String, dynamic> json) {
  final LikeListCompanyDataUserData likeListCompanyDataUserData = LikeListCompanyDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    likeListCompanyDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    likeListCompanyDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    likeListCompanyDataUserData.userimage = userimage;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    likeListCompanyDataUserData.immlm = immlm;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    likeListCompanyDataUserData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    likeListCompanyDataUserData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    likeListCompanyDataUserData.country = country;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    likeListCompanyDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    likeListCompanyDataUserData.imageThumPath = imageThumPath;
  }
  return likeListCompanyDataUserData;
}

Map<String, dynamic> $LikeListCompanyDataUserDataToJson(
    LikeListCompanyDataUserData entity) {
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

extension LikeListCompanyDataUserDataExtension on LikeListCompanyDataUserData {
  LikeListCompanyDataUserData copyWith({
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
    return LikeListCompanyDataUserData()
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