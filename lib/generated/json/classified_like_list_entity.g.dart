import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/classified_like_list_entity.dart';

ClassifiedLikeListEntity $ClassifiedLikeListEntityFromJson(
    Map<String, dynamic> json) {
  final ClassifiedLikeListEntity classifiedLikeListEntity = ClassifiedLikeListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    classifiedLikeListEntity.status = status;
  }
  final List<ClassifiedLikeListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ClassifiedLikeListData>(e) as ClassifiedLikeListData)
      .toList();
  if (data != null) {
    classifiedLikeListEntity.data = data;
  }
  return classifiedLikeListEntity;
}

Map<String, dynamic> $ClassifiedLikeListEntityToJson(
    ClassifiedLikeListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ClassifiedLikeListEntityExtension on ClassifiedLikeListEntity {
  ClassifiedLikeListEntity copyWith({
    int? status,
    List<ClassifiedLikeListData>? data,
  }) {
    return ClassifiedLikeListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ClassifiedLikeListData $ClassifiedLikeListDataFromJson(
    Map<String, dynamic> json) {
  final ClassifiedLikeListData classifiedLikeListData = ClassifiedLikeListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    classifiedLikeListData.id = id;
  }
  final int? cid = jsonConvert.convert<int>(json['cid']);
  if (cid != null) {
    classifiedLikeListData.cid = cid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    classifiedLikeListData.userid = userid;
  }
  final String? addeddate = jsonConvert.convert<String>(json['addeddate']);
  if (addeddate != null) {
    classifiedLikeListData.addeddate = addeddate;
  }
  final dynamic ipaddress = json['ipaddress'];
  if (ipaddress != null) {
    classifiedLikeListData.ipaddress = ipaddress;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    classifiedLikeListData.type = type;
  }
  final String? ntype = jsonConvert.convert<String>(json['ntype']);
  if (ntype != null) {
    classifiedLikeListData.ntype = ntype;
  }
  final dynamic distype = json['distype'];
  if (distype != null) {
    classifiedLikeListData.distype = distype;
  }
  final ClassifiedLikeListDataUserData? userData = jsonConvert.convert<
      ClassifiedLikeListDataUserData>(json['user_data']);
  if (userData != null) {
    classifiedLikeListData.userData = userData;
  }
  return classifiedLikeListData;
}

Map<String, dynamic> $ClassifiedLikeListDataToJson(
    ClassifiedLikeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['cid'] = entity.cid;
  data['userid'] = entity.userid;
  data['addeddate'] = entity.addeddate;
  data['ipaddress'] = entity.ipaddress;
  data['type'] = entity.type;
  data['ntype'] = entity.ntype;
  data['distype'] = entity.distype;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension ClassifiedLikeListDataExtension on ClassifiedLikeListData {
  ClassifiedLikeListData copyWith({
    int? id,
    int? cid,
    int? userid,
    String? addeddate,
    dynamic ipaddress,
    String? type,
    String? ntype,
    dynamic distype,
    ClassifiedLikeListDataUserData? userData,
  }) {
    return ClassifiedLikeListData()
      ..id = id ?? this.id
      ..cid = cid ?? this.cid
      ..userid = userid ?? this.userid
      ..addeddate = addeddate ?? this.addeddate
      ..ipaddress = ipaddress ?? this.ipaddress
      ..type = type ?? this.type
      ..ntype = ntype ?? this.ntype
      ..distype = distype ?? this.distype
      ..userData = userData ?? this.userData;
  }
}

ClassifiedLikeListDataUserData $ClassifiedLikeListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ClassifiedLikeListDataUserData classifiedLikeListDataUserData = ClassifiedLikeListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    classifiedLikeListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    classifiedLikeListDataUserData.name = name;
  }
  final dynamic userimage = json['userimage'];
  if (userimage != null) {
    classifiedLikeListDataUserData.userimage = userimage;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    classifiedLikeListDataUserData.immlm = immlm;
  }
  final dynamic city = json['city'];
  if (city != null) {
    classifiedLikeListDataUserData.city = city;
  }
  final dynamic state = json['state'];
  if (state != null) {
    classifiedLikeListDataUserData.state = state;
  }
  final dynamic country = json['country'];
  if (country != null) {
    classifiedLikeListDataUserData.country = country;
  }
  final dynamic imagePath = json['image_path'];
  if (imagePath != null) {
    classifiedLikeListDataUserData.imagePath = imagePath;
  }
  final dynamic imageThumPath = json['image_thum_path'];
  if (imageThumPath != null) {
    classifiedLikeListDataUserData.imageThumPath = imageThumPath;
  }
  return classifiedLikeListDataUserData;
}

Map<String, dynamic> $ClassifiedLikeListDataUserDataToJson(
    ClassifiedLikeListDataUserData entity) {
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

extension ClassifiedLikeListDataUserDataExtension on ClassifiedLikeListDataUserData {
  ClassifiedLikeListDataUserData copyWith({
    int? id,
    String? name,
    dynamic userimage,
    String? immlm,
    dynamic city,
    dynamic state,
    dynamic country,
    dynamic imagePath,
    dynamic imageThumPath,
  }) {
    return ClassifiedLikeListDataUserData()
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