import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_user_profile_entity.dart';

UpdateUserProfileEntity $UpdateUserProfileEntityFromJson(
    Map<String, dynamic> json) {
  final UpdateUserProfileEntity updateUserProfileEntity = UpdateUserProfileEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    updateUserProfileEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updateUserProfileEntity.message = message;
  }
  final UpdateUserProfileUserProfile? userProfile = jsonConvert.convert<
      UpdateUserProfileUserProfile>(json['user_profile']);
  if (userProfile != null) {
    updateUserProfileEntity.userProfile = userProfile;
  }
  return updateUserProfileEntity;
}

Map<String, dynamic> $UpdateUserProfileEntityToJson(
    UpdateUserProfileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  data['user_profile'] = entity.userProfile?.toJson();
  return data;
}

extension UpdateUserProfileEntityExtension on UpdateUserProfileEntity {
  UpdateUserProfileEntity copyWith({
    int? result,
    String? message,
    UpdateUserProfileUserProfile? userProfile,
  }) {
    return UpdateUserProfileEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message
      ..userProfile = userProfile ?? this.userProfile;
  }
}

UpdateUserProfileUserProfile $UpdateUserProfileUserProfileFromJson(
    Map<String, dynamic> json) {
  final UpdateUserProfileUserProfile updateUserProfileUserProfile = UpdateUserProfileUserProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    updateUserProfileUserProfile.id = id;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    updateUserProfileUserProfile.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    updateUserProfileUserProfile.name = name;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    updateUserProfileUserProfile.immlm = immlm;
  }
  final dynamic company = json['company'];
  if (company != null) {
    updateUserProfileUserProfile.company = company;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    updateUserProfileUserProfile.plan = plan;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    updateUserProfileUserProfile.address = address;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    updateUserProfileUserProfile.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    updateUserProfileUserProfile.state = state;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    updateUserProfileUserProfile.pincode = pincode;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    updateUserProfileUserProfile.country = country;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    updateUserProfileUserProfile.userimage = userimage;
  }
  return updateUserProfileUserProfile;
}

Map<String, dynamic> $UpdateUserProfileUserProfileToJson(
    UpdateUserProfileUserProfile entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['sex'] = entity.sex;
  data['name'] = entity.name;
  data['immlm'] = entity.immlm;
  data['company'] = entity.company;
  data['plan'] = entity.plan;
  data['address'] = entity.address;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['pincode'] = entity.pincode;
  data['country'] = entity.country;
  data['userimage'] = entity.userimage;
  return data;
}

extension UpdateUserProfileUserProfileExtension on UpdateUserProfileUserProfile {
  UpdateUserProfileUserProfile copyWith({
    int? id,
    String? sex,
    String? name,
    String? immlm,
    dynamic company,
    String? plan,
    String? address,
    String? city,
    String? state,
    String? pincode,
    String? country,
    String? userimage,
  }) {
    return UpdateUserProfileUserProfile()
      ..id = id ?? this.id
      ..sex = sex ?? this.sex
      ..name = name ?? this.name
      ..immlm = immlm ?? this.immlm
      ..company = company ?? this.company
      ..plan = plan ?? this.plan
      ..address = address ?? this.address
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..pincode = pincode ?? this.pincode
      ..country = country ?? this.country
      ..userimage = userimage ?? this.userimage;
  }
}