import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_tutorial_video_entity.dart';

GetTutorialVideoEntity $GetTutorialVideoEntityFromJson(
    Map<String, dynamic> json) {
  final GetTutorialVideoEntity getTutorialVideoEntity = GetTutorialVideoEntity();
  final int? success = jsonConvert.convert<int>(json['success']);
  if (success != null) {
    getTutorialVideoEntity.success = success;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getTutorialVideoEntity.message = message;
  }
  final GetTutorialVideoData? data = jsonConvert.convert<GetTutorialVideoData>(
      json['data']);
  if (data != null) {
    getTutorialVideoEntity.data = data;
  }
  return getTutorialVideoEntity;
}

Map<String, dynamic> $GetTutorialVideoEntityToJson(
    GetTutorialVideoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension GetTutorialVideoEntityExtension on GetTutorialVideoEntity {
  GetTutorialVideoEntity copyWith({
    int? success,
    String? message,
    GetTutorialVideoData? data,
  }) {
    return GetTutorialVideoEntity()
      ..success = success ?? this.success
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetTutorialVideoData $GetTutorialVideoDataFromJson(Map<String, dynamic> json) {
  final GetTutorialVideoData getTutorialVideoData = GetTutorialVideoData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getTutorialVideoData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getTutorialVideoData.title = title;
  }
  final String? video = jsonConvert.convert<String>(json['video']);
  if (video != null) {
    getTutorialVideoData.video = video;
  }
  final String? position = jsonConvert.convert<String>(json['position']);
  if (position != null) {
    getTutorialVideoData.position = position;
  }
  return getTutorialVideoData;
}

Map<String, dynamic> $GetTutorialVideoDataToJson(GetTutorialVideoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['video'] = entity.video;
  data['position'] = entity.position;
  return data;
}

extension GetTutorialVideoDataExtension on GetTutorialVideoData {
  GetTutorialVideoData copyWith({
    int? id,
    String? title,
    String? video,
    String? position,
  }) {
    return GetTutorialVideoData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..video = video ?? this.video
      ..position = position ?? this.position;
  }
}