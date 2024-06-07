import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/post_like_list_entity.dart';

PostLikeListEntity $PostLikeListEntityFromJson(Map<String, dynamic> json) {
  final PostLikeListEntity postLikeListEntity = PostLikeListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    postLikeListEntity.status = status;
  }
  final List<PostLikeListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<PostLikeListData>(e) as PostLikeListData)
      .toList();
  if (data != null) {
    postLikeListEntity.data = data;
  }
  return postLikeListEntity;
}

Map<String, dynamic> $PostLikeListEntityToJson(PostLikeListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension PostLikeListEntityExtension on PostLikeListEntity {
  PostLikeListEntity copyWith({
    int? status,
    List<PostLikeListData>? data,
  }) {
    return PostLikeListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

PostLikeListData $PostLikeListDataFromJson(Map<String, dynamic> json) {
  final PostLikeListData postLikeListData = PostLikeListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    postLikeListData.id = id;
  }
  final int? pid = jsonConvert.convert<int>(json['pid']);
  if (pid != null) {
    postLikeListData.pid = pid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    postLikeListData.userid = userid;
  }
  final String? addeddate = jsonConvert.convert<String>(json['addeddate']);
  if (addeddate != null) {
    postLikeListData.addeddate = addeddate;
  }
  final String? ipaddress = jsonConvert.convert<String>(json['ipaddress']);
  if (ipaddress != null) {
    postLikeListData.ipaddress = ipaddress;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    postLikeListData.type = type;
  }
  final String? ntype = jsonConvert.convert<String>(json['ntype']);
  if (ntype != null) {
    postLikeListData.ntype = ntype;
  }
  final dynamic distype = json['distype'];
  if (distype != null) {
    postLikeListData.distype = distype;
  }
  final PostLikeListDataUserData? userData = jsonConvert.convert<
      PostLikeListDataUserData>(json['user_data']);
  if (userData != null) {
    postLikeListData.userData = userData;
  }
  return postLikeListData;
}

Map<String, dynamic> $PostLikeListDataToJson(PostLikeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['pid'] = entity.pid;
  data['userid'] = entity.userid;
  data['addeddate'] = entity.addeddate;
  data['ipaddress'] = entity.ipaddress;
  data['type'] = entity.type;
  data['ntype'] = entity.ntype;
  data['distype'] = entity.distype;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension PostLikeListDataExtension on PostLikeListData {
  PostLikeListData copyWith({
    int? id,
    int? pid,
    int? userid,
    String? addeddate,
    String? ipaddress,
    String? type,
    String? ntype,
    dynamic distype,
    PostLikeListDataUserData? userData,
  }) {
    return PostLikeListData()
      ..id = id ?? this.id
      ..pid = pid ?? this.pid
      ..userid = userid ?? this.userid
      ..addeddate = addeddate ?? this.addeddate
      ..ipaddress = ipaddress ?? this.ipaddress
      ..type = type ?? this.type
      ..ntype = ntype ?? this.ntype
      ..distype = distype ?? this.distype
      ..userData = userData ?? this.userData;
  }
}

PostLikeListDataUserData $PostLikeListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final PostLikeListDataUserData postLikeListDataUserData = PostLikeListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    postLikeListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    postLikeListDataUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    postLikeListDataUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    postLikeListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    postLikeListDataUserData.imageThumPath = imageThumPath;
  }
  return postLikeListDataUserData;
}

Map<String, dynamic> $PostLikeListDataUserDataToJson(
    PostLikeListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension PostLikeListDataUserDataExtension on PostLikeListDataUserData {
  PostLikeListDataUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return PostLikeListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}