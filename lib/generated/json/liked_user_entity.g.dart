import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/liked_user_entity.dart';

LikedUserEntity $LikedUserEntityFromJson(Map<String, dynamic> json) {
  final LikedUserEntity likedUserEntity = LikedUserEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    likedUserEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    likedUserEntity.message = message;
  }
  return likedUserEntity;
}

Map<String, dynamic> $LikedUserEntityToJson(LikedUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension LikedUserEntityExtension on LikedUserEntity {
  LikedUserEntity copyWith({
    int? status,
    String? message,
  }) {
    return LikedUserEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}