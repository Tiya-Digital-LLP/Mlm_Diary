import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/question_like_list_entity.dart';

QuestionLikeListEntity $QuestionLikeListEntityFromJson(
    Map<String, dynamic> json) {
  final QuestionLikeListEntity questionLikeListEntity = QuestionLikeListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    questionLikeListEntity.status = status;
  }
  final List<QuestionLikeListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<QuestionLikeListData>(e) as QuestionLikeListData)
      .toList();
  if (data != null) {
    questionLikeListEntity.data = data;
  }
  return questionLikeListEntity;
}

Map<String, dynamic> $QuestionLikeListEntityToJson(
    QuestionLikeListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension QuestionLikeListEntityExtension on QuestionLikeListEntity {
  QuestionLikeListEntity copyWith({
    int? status,
    List<QuestionLikeListData>? data,
  }) {
    return QuestionLikeListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

QuestionLikeListData $QuestionLikeListDataFromJson(Map<String, dynamic> json) {
  final QuestionLikeListData questionLikeListData = QuestionLikeListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    questionLikeListData.id = id;
  }
  final int? qid = jsonConvert.convert<int>(json['qid']);
  if (qid != null) {
    questionLikeListData.qid = qid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    questionLikeListData.userid = userid;
  }
  final String? addeddate = jsonConvert.convert<String>(json['addeddate']);
  if (addeddate != null) {
    questionLikeListData.addeddate = addeddate;
  }
  final String? ipaddress = jsonConvert.convert<String>(json['ipaddress']);
  if (ipaddress != null) {
    questionLikeListData.ipaddress = ipaddress;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    questionLikeListData.type = type;
  }
  final String? ntype = jsonConvert.convert<String>(json['ntype']);
  if (ntype != null) {
    questionLikeListData.ntype = ntype;
  }
  final String? distype = jsonConvert.convert<String>(json['distype']);
  if (distype != null) {
    questionLikeListData.distype = distype;
  }
  final QuestionLikeListDataUserData? userData = jsonConvert.convert<
      QuestionLikeListDataUserData>(json['user_data']);
  if (userData != null) {
    questionLikeListData.userData = userData;
  }
  return questionLikeListData;
}

Map<String, dynamic> $QuestionLikeListDataToJson(QuestionLikeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['qid'] = entity.qid;
  data['userid'] = entity.userid;
  data['addeddate'] = entity.addeddate;
  data['ipaddress'] = entity.ipaddress;
  data['type'] = entity.type;
  data['ntype'] = entity.ntype;
  data['distype'] = entity.distype;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension QuestionLikeListDataExtension on QuestionLikeListData {
  QuestionLikeListData copyWith({
    int? id,
    int? qid,
    int? userid,
    String? addeddate,
    String? ipaddress,
    String? type,
    String? ntype,
    String? distype,
    QuestionLikeListDataUserData? userData,
  }) {
    return QuestionLikeListData()
      ..id = id ?? this.id
      ..qid = qid ?? this.qid
      ..userid = userid ?? this.userid
      ..addeddate = addeddate ?? this.addeddate
      ..ipaddress = ipaddress ?? this.ipaddress
      ..type = type ?? this.type
      ..ntype = ntype ?? this.ntype
      ..distype = distype ?? this.distype
      ..userData = userData ?? this.userData;
  }
}

QuestionLikeListDataUserData $QuestionLikeListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final QuestionLikeListDataUserData questionLikeListDataUserData = QuestionLikeListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    questionLikeListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    questionLikeListDataUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    questionLikeListDataUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    questionLikeListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    questionLikeListDataUserData.imageThumPath = imageThumPath;
  }
  return questionLikeListDataUserData;
}

Map<String, dynamic> $QuestionLikeListDataUserDataToJson(
    QuestionLikeListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension QuestionLikeListDataUserDataExtension on QuestionLikeListDataUserData {
  QuestionLikeListDataUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return QuestionLikeListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}