import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/follow_user_entity.dart';

FollowUserEntity $FollowUserEntityFromJson(Map<String, dynamic> json) {
  final FollowUserEntity followUserEntity = FollowUserEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    followUserEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    followUserEntity.message = message;
  }
  return followUserEntity;
}

Map<String, dynamic> $FollowUserEntityToJson(FollowUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension FollowUserEntityExtension on FollowUserEntity {
  FollowUserEntity copyWith({
    int? status,
    String? message,
  }) {
    return FollowUserEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}