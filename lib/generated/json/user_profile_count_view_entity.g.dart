import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/user_profile_count_view_entity.dart';

UserProfileCountViewEntity $UserProfileCountViewEntityFromJson(
    Map<String, dynamic> json) {
  final UserProfileCountViewEntity userProfileCountViewEntity = UserProfileCountViewEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userProfileCountViewEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userProfileCountViewEntity.message = message;
  }
  return userProfileCountViewEntity;
}

Map<String, dynamic> $UserProfileCountViewEntityToJson(
    UserProfileCountViewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension UserProfileCountViewEntityExtension on UserProfileCountViewEntity {
  UserProfileCountViewEntity copyWith({
    int? status,
    String? message,
  }) {
    return UserProfileCountViewEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}