import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_social_media_entity.dart';

UpdateSocialMediaEntity $UpdateSocialMediaEntityFromJson(
    Map<String, dynamic> json) {
  final UpdateSocialMediaEntity updateSocialMediaEntity = UpdateSocialMediaEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    updateSocialMediaEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updateSocialMediaEntity.message = message;
  }
  final UpdateSocialMediaUserProfile? userProfile = jsonConvert.convert<
      UpdateSocialMediaUserProfile>(json['user_profile']);
  if (userProfile != null) {
    updateSocialMediaEntity.userProfile = userProfile;
  }
  return updateSocialMediaEntity;
}

Map<String, dynamic> $UpdateSocialMediaEntityToJson(
    UpdateSocialMediaEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  data['user_profile'] = entity.userProfile?.toJson();
  return data;
}

extension UpdateSocialMediaEntityExtension on UpdateSocialMediaEntity {
  UpdateSocialMediaEntity copyWith({
    int? result,
    String? message,
    UpdateSocialMediaUserProfile? userProfile,
  }) {
    return UpdateSocialMediaEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message
      ..userProfile = userProfile ?? this.userProfile;
  }
}

UpdateSocialMediaUserProfile $UpdateSocialMediaUserProfileFromJson(
    Map<String, dynamic> json) {
  final UpdateSocialMediaUserProfile updateSocialMediaUserProfile = UpdateSocialMediaUserProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    updateSocialMediaUserProfile.id = id;
  }
  final dynamic website = json['website'];
  if (website != null) {
    updateSocialMediaUserProfile.website = website;
  }
  final String? compWebsite = jsonConvert.convert<String>(json['comp_website']);
  if (compWebsite != null) {
    updateSocialMediaUserProfile.compWebsite = compWebsite;
  }
  final String? fblink = jsonConvert.convert<String>(json['fblink']);
  if (fblink != null) {
    updateSocialMediaUserProfile.fblink = fblink;
  }
  final String? instalink = jsonConvert.convert<String>(json['instalink']);
  if (instalink != null) {
    updateSocialMediaUserProfile.instalink = instalink;
  }
  final dynamic twiterlink = json['twiterlink'];
  if (twiterlink != null) {
    updateSocialMediaUserProfile.twiterlink = twiterlink;
  }
  final dynamic lilink = json['lilink'];
  if (lilink != null) {
    updateSocialMediaUserProfile.lilink = lilink;
  }
  final dynamic youlink = json['youlink'];
  if (youlink != null) {
    updateSocialMediaUserProfile.youlink = youlink;
  }
  final dynamic wplink = json['wplink'];
  if (wplink != null) {
    updateSocialMediaUserProfile.wplink = wplink;
  }
  final dynamic telink = json['telink'];
  if (telink != null) {
    updateSocialMediaUserProfile.telink = telink;
  }
  return updateSocialMediaUserProfile;
}

Map<String, dynamic> $UpdateSocialMediaUserProfileToJson(
    UpdateSocialMediaUserProfile entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['website'] = entity.website;
  data['comp_website'] = entity.compWebsite;
  data['fblink'] = entity.fblink;
  data['instalink'] = entity.instalink;
  data['twiterlink'] = entity.twiterlink;
  data['lilink'] = entity.lilink;
  data['youlink'] = entity.youlink;
  data['wplink'] = entity.wplink;
  data['telink'] = entity.telink;
  return data;
}

extension UpdateSocialMediaUserProfileExtension on UpdateSocialMediaUserProfile {
  UpdateSocialMediaUserProfile copyWith({
    int? id,
    dynamic website,
    String? compWebsite,
    String? fblink,
    String? instalink,
    dynamic twiterlink,
    dynamic lilink,
    dynamic youlink,
    dynamic wplink,
    dynamic telink,
  }) {
    return UpdateSocialMediaUserProfile()
      ..id = id ?? this.id
      ..website = website ?? this.website
      ..compWebsite = compWebsite ?? this.compWebsite
      ..fblink = fblink ?? this.fblink
      ..instalink = instalink ?? this.instalink
      ..twiterlink = twiterlink ?? this.twiterlink
      ..lilink = lilink ?? this.lilink
      ..youlink = youlink ?? this.youlink
      ..wplink = wplink ?? this.wplink
      ..telink = telink ?? this.telink;
  }
}