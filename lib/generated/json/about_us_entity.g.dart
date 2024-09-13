import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/about_us_entity.dart';

AboutUsEntity $AboutUsEntityFromJson(Map<String, dynamic> json) {
  final AboutUsEntity aboutUsEntity = AboutUsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    aboutUsEntity.status = status;
  }
  final AboutUsAbout? about = jsonConvert.convert<AboutUsAbout>(json['about']);
  if (about != null) {
    aboutUsEntity.about = about;
  }
  return aboutUsEntity;
}

Map<String, dynamic> $AboutUsEntityToJson(AboutUsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['about'] = entity.about.toJson();
  return data;
}

extension AboutUsEntityExtension on AboutUsEntity {
  AboutUsEntity copyWith({
    int? status,
    AboutUsAbout? about,
  }) {
    return AboutUsEntity()
      ..status = status ?? this.status
      ..about = about ?? this.about;
  }
}

AboutUsAbout $AboutUsAboutFromJson(Map<String, dynamic> json) {
  final AboutUsAbout aboutUsAbout = AboutUsAbout();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    aboutUsAbout.id = id;
  }
  final String? description1 = jsonConvert.convert<String>(
      json['description1']);
  if (description1 != null) {
    aboutUsAbout.description1 = description1;
  }
  final String? title1 = jsonConvert.convert<String>(json['title1']);
  if (title1 != null) {
    aboutUsAbout.title1 = title1;
  }
  final String? description2 = jsonConvert.convert<String>(
      json['description2']);
  if (description2 != null) {
    aboutUsAbout.description2 = description2;
  }
  final String? title2 = jsonConvert.convert<String>(json['title2']);
  if (title2 != null) {
    aboutUsAbout.title2 = title2;
  }
  final String? description3 = jsonConvert.convert<String>(
      json['description3']);
  if (description3 != null) {
    aboutUsAbout.description3 = description3;
  }
  final String? title3 = jsonConvert.convert<String>(json['title3']);
  if (title3 != null) {
    aboutUsAbout.title3 = title3;
  }
  final String? description4 = jsonConvert.convert<String>(
      json['description4']);
  if (description4 != null) {
    aboutUsAbout.description4 = description4;
  }
  final String? title4 = jsonConvert.convert<String>(json['title4']);
  if (title4 != null) {
    aboutUsAbout.title4 = title4;
  }
  final dynamic description5 = json['description5'];
  if (description5 != null) {
    aboutUsAbout.description5 = description5;
  }
  final dynamic title5 = json['title5'];
  if (title5 != null) {
    aboutUsAbout.title5 = title5;
  }
  return aboutUsAbout;
}

Map<String, dynamic> $AboutUsAboutToJson(AboutUsAbout entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['description1'] = entity.description1;
  data['title1'] = entity.title1;
  data['description2'] = entity.description2;
  data['title2'] = entity.title2;
  data['description3'] = entity.description3;
  data['title3'] = entity.title3;
  data['description4'] = entity.description4;
  data['title4'] = entity.title4;
  data['description5'] = entity.description5;
  data['title5'] = entity.title5;
  return data;
}

extension AboutUsAboutExtension on AboutUsAbout {
  AboutUsAbout copyWith({
    int? id,
    String? description1,
    String? title1,
    String? description2,
    String? title2,
    String? description3,
    String? title3,
    String? description4,
    String? title4,
    dynamic description5,
    dynamic title5,
  }) {
    return AboutUsAbout()
      ..id = id ?? this.id
      ..description1 = description1 ?? this.description1
      ..title1 = title1 ?? this.title1
      ..description2 = description2 ?? this.description2
      ..title2 = title2 ?? this.title2
      ..description3 = description3 ?? this.description3
      ..title3 = title3 ?? this.title3
      ..description4 = description4 ?? this.description4
      ..title4 = title4 ?? this.title4
      ..description5 = description5 ?? this.description5
      ..title5 = title5 ?? this.title5;
  }
}