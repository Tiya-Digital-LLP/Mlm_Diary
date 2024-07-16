import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/mlm_social_media_entity.dart';

MlmSocialMediaEntity $MlmSocialMediaEntityFromJson(Map<String, dynamic> json) {
  final MlmSocialMediaEntity mlmSocialMediaEntity = MlmSocialMediaEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    mlmSocialMediaEntity.status = status;
  }
  final MlmSocialMediaSitesetting? sitesetting = jsonConvert.convert<
      MlmSocialMediaSitesetting>(json['sitesetting']);
  if (sitesetting != null) {
    mlmSocialMediaEntity.sitesetting = sitesetting;
  }
  return mlmSocialMediaEntity;
}

Map<String, dynamic> $MlmSocialMediaEntityToJson(MlmSocialMediaEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['sitesetting'] = entity.sitesetting?.toJson();
  return data;
}

extension MlmSocialMediaEntityExtension on MlmSocialMediaEntity {
  MlmSocialMediaEntity copyWith({
    int? status,
    MlmSocialMediaSitesetting? sitesetting,
  }) {
    return MlmSocialMediaEntity()
      ..status = status ?? this.status
      ..sitesetting = sitesetting ?? this.sitesetting;
  }
}

MlmSocialMediaSitesetting $MlmSocialMediaSitesettingFromJson(
    Map<String, dynamic> json) {
  final MlmSocialMediaSitesetting mlmSocialMediaSitesetting = MlmSocialMediaSitesetting();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    mlmSocialMediaSitesetting.id = id;
  }
  final String? facebookLink = jsonConvert.convert<String>(
      json['facebook_link']);
  if (facebookLink != null) {
    mlmSocialMediaSitesetting.facebookLink = facebookLink;
  }
  final String? whatsapp = jsonConvert.convert<String>(json['whatsapp']);
  if (whatsapp != null) {
    mlmSocialMediaSitesetting.whatsapp = whatsapp;
  }
  final String? intagramLink = jsonConvert.convert<String>(
      json['intagram_link']);
  if (intagramLink != null) {
    mlmSocialMediaSitesetting.intagramLink = intagramLink;
  }
  final String? linkedinLink = jsonConvert.convert<String>(
      json['linkedin_link']);
  if (linkedinLink != null) {
    mlmSocialMediaSitesetting.linkedinLink = linkedinLink;
  }
  final String? youtubeLink = jsonConvert.convert<String>(json['youtube_link']);
  if (youtubeLink != null) {
    mlmSocialMediaSitesetting.youtubeLink = youtubeLink;
  }
  final String? telegramLink = jsonConvert.convert<String>(
      json['telegram_link']);
  if (telegramLink != null) {
    mlmSocialMediaSitesetting.telegramLink = telegramLink;
  }
  final String? twitterLink = jsonConvert.convert<String>(json['twitter_link']);
  if (twitterLink != null) {
    mlmSocialMediaSitesetting.twitterLink = twitterLink;
  }
  return mlmSocialMediaSitesetting;
}

Map<String, dynamic> $MlmSocialMediaSitesettingToJson(
    MlmSocialMediaSitesetting entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['facebook_link'] = entity.facebookLink;
  data['whatsapp'] = entity.whatsapp;
  data['intagram_link'] = entity.intagramLink;
  data['linkedin_link'] = entity.linkedinLink;
  data['youtube_link'] = entity.youtubeLink;
  data['telegram_link'] = entity.telegramLink;
  data['twitter_link'] = entity.twitterLink;
  return data;
}

extension MlmSocialMediaSitesettingExtension on MlmSocialMediaSitesetting {
  MlmSocialMediaSitesetting copyWith({
    int? id,
    String? facebookLink,
    String? whatsapp,
    String? intagramLink,
    String? linkedinLink,
    String? youtubeLink,
    String? telegramLink,
    String? twitterLink,
  }) {
    return MlmSocialMediaSitesetting()
      ..id = id ?? this.id
      ..facebookLink = facebookLink ?? this.facebookLink
      ..whatsapp = whatsapp ?? this.whatsapp
      ..intagramLink = intagramLink ?? this.intagramLink
      ..linkedinLink = linkedinLink ?? this.linkedinLink
      ..youtubeLink = youtubeLink ?? this.youtubeLink
      ..telegramLink = telegramLink ?? this.telegramLink
      ..twitterLink = twitterLink ?? this.twitterLink;
  }
}