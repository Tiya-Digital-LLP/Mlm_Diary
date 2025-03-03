import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/view_question_list_entity.dart';

ViewQuestionListEntity $ViewQuestionListEntityFromJson(
    Map<String, dynamic> json) {
  final ViewQuestionListEntity viewQuestionListEntity = ViewQuestionListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    viewQuestionListEntity.status = status;
  }
  final List<ViewQuestionListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ViewQuestionListData>(e) as ViewQuestionListData)
      .toList();
  if (data != null) {
    viewQuestionListEntity.data = data;
  }
  return viewQuestionListEntity;
}

Map<String, dynamic> $ViewQuestionListEntityToJson(
    ViewQuestionListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ViewQuestionListEntityExtension on ViewQuestionListEntity {
  ViewQuestionListEntity copyWith({
    int? status,
    List<ViewQuestionListData>? data,
  }) {
    return ViewQuestionListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ViewQuestionListData $ViewQuestionListDataFromJson(Map<String, dynamic> json) {
  final ViewQuestionListData viewQuestionListData = ViewQuestionListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewQuestionListData.id = id;
  }
  final int? qid = jsonConvert.convert<int>(json['qid']);
  if (qid != null) {
    viewQuestionListData.qid = qid;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    viewQuestionListData.userId = userId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    viewQuestionListData.createdAt = createdAt;
  }
  final ViewQuestionListDataUserData? userData = jsonConvert.convert<
      ViewQuestionListDataUserData>(json['user_data']);
  if (userData != null) {
    viewQuestionListData.userData = userData;
  }
  return viewQuestionListData;
}

Map<String, dynamic> $ViewQuestionListDataToJson(ViewQuestionListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['qid'] = entity.qid;
  data['user_id'] = entity.userId;
  data['created_at'] = entity.createdAt;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension ViewQuestionListDataExtension on ViewQuestionListData {
  ViewQuestionListData copyWith({
    int? id,
    int? qid,
    int? userId,
    String? createdAt,
    ViewQuestionListDataUserData? userData,
  }) {
    return ViewQuestionListData()
      ..id = id ?? this.id
      ..qid = qid ?? this.qid
      ..userId = userId ?? this.userId
      ..createdAt = createdAt ?? this.createdAt
      ..userData = userData ?? this.userData;
  }
}

ViewQuestionListDataUserData $ViewQuestionListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ViewQuestionListDataUserData viewQuestionListDataUserData = ViewQuestionListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    viewQuestionListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    viewQuestionListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    viewQuestionListDataUserData.userimage = userimage;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    viewQuestionListDataUserData.immlm = immlm;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    viewQuestionListDataUserData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    viewQuestionListDataUserData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    viewQuestionListDataUserData.country = country;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    viewQuestionListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    viewQuestionListDataUserData.imageThumPath = imageThumPath;
  }
  return viewQuestionListDataUserData;
}

Map<String, dynamic> $ViewQuestionListDataUserDataToJson(
    ViewQuestionListDataUserData entity) {
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

extension ViewQuestionListDataUserDataExtension on ViewQuestionListDataUserData {
  ViewQuestionListDataUserData copyWith({
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
    return ViewQuestionListDataUserData()
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