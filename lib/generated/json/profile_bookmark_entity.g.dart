import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/profile_bookmark_entity.dart';

ProfileBookmarkEntity $ProfileBookmarkEntityFromJson(
    Map<String, dynamic> json) {
  final ProfileBookmarkEntity profileBookmarkEntity = ProfileBookmarkEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    profileBookmarkEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    profileBookmarkEntity.message = message;
  }
  return profileBookmarkEntity;
}

Map<String, dynamic> $ProfileBookmarkEntityToJson(
    ProfileBookmarkEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension ProfileBookmarkEntityExtension on ProfileBookmarkEntity {
  ProfileBookmarkEntity copyWith({
    int? status,
    String? message,
  }) {
    return ProfileBookmarkEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}