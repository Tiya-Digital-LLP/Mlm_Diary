import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_answers_entity.dart';

GetAnswersEntity $GetAnswersEntityFromJson(Map<String, dynamic> json) {
  final GetAnswersEntity getAnswersEntity = GetAnswersEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getAnswersEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getAnswersEntity.message = message;
  }
  final List<GetAnswersAnswers>? answers = (json['answers'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetAnswersAnswers>(e) as GetAnswersAnswers)
      .toList();
  if (answers != null) {
    getAnswersEntity.answers = answers;
  }
  return getAnswersEntity;
}

Map<String, dynamic> $GetAnswersEntityToJson(GetAnswersEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['answers'] = entity.answers?.map((v) => v.toJson()).toList();
  return data;
}

extension GetAnswersEntityExtension on GetAnswersEntity {
  GetAnswersEntity copyWith({
    int? status,
    String? message,
    List<GetAnswersAnswers>? answers,
  }) {
    return GetAnswersEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..answers = answers ?? this.answers;
  }
}

GetAnswersAnswers $GetAnswersAnswersFromJson(Map<String, dynamic> json) {
  final GetAnswersAnswers getAnswersAnswers = GetAnswersAnswers();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getAnswersAnswers.id = id;
  }
  final String? ansTitle = jsonConvert.convert<String>(json['ans_title']);
  if (ansTitle != null) {
    getAnswersAnswers.ansTitle = ansTitle;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getAnswersAnswers.createdate = createdate;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    getAnswersAnswers.userId = userId;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getAnswersAnswers.totallike = totallike;
  }
  final int? userliked = jsonConvert.convert<int>(json['userliked']);
  if (userliked != null) {
    getAnswersAnswers.userliked = userliked;
  }
  final GetAnswersAnswersUserData? userData = jsonConvert.convert<
      GetAnswersAnswersUserData>(json['user_data']);
  if (userData != null) {
    getAnswersAnswers.userData = userData;
  }
  return getAnswersAnswers;
}

Map<String, dynamic> $GetAnswersAnswersToJson(GetAnswersAnswers entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ans_title'] = entity.ansTitle;
  data['createdate'] = entity.createdate;
  data['user_id'] = entity.userId;
  data['totallike'] = entity.totallike;
  data['userliked'] = entity.userliked;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension GetAnswersAnswersExtension on GetAnswersAnswers {
  GetAnswersAnswers copyWith({
    int? id,
    String? ansTitle,
    String? createdate,
    int? userId,
    int? totallike,
    int? userliked,
    GetAnswersAnswersUserData? userData,
  }) {
    return GetAnswersAnswers()
      ..id = id ?? this.id
      ..ansTitle = ansTitle ?? this.ansTitle
      ..createdate = createdate ?? this.createdate
      ..userId = userId ?? this.userId
      ..totallike = totallike ?? this.totallike
      ..userliked = userliked ?? this.userliked
      ..userData = userData ?? this.userData;
  }
}

GetAnswersAnswersUserData $GetAnswersAnswersUserDataFromJson(
    Map<String, dynamic> json) {
  final GetAnswersAnswersUserData getAnswersAnswersUserData = GetAnswersAnswersUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getAnswersAnswersUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getAnswersAnswersUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getAnswersAnswersUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getAnswersAnswersUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getAnswersAnswersUserData.imageThumPath = imageThumPath;
  }
  return getAnswersAnswersUserData;
}

Map<String, dynamic> $GetAnswersAnswersUserDataToJson(
    GetAnswersAnswersUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetAnswersAnswersUserDataExtension on GetAnswersAnswersUserData {
  GetAnswersAnswersUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetAnswersAnswersUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}