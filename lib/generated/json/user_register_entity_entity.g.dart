import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/user_register_entity_entity.dart';

UserRegisterEntityEntity $UserRegisterEntityEntityFromJson(
    Map<String, dynamic> json) {
  final UserRegisterEntityEntity userRegisterEntityEntity = UserRegisterEntityEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userRegisterEntityEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userRegisterEntityEntity.status = status;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    userRegisterEntityEntity.userId = userId;
  }
  final String? apiToken = jsonConvert.convert<String>(json['api_token']);
  if (apiToken != null) {
    userRegisterEntityEntity.apiToken = apiToken;
  }
  return userRegisterEntityEntity;
}

Map<String, dynamic> $UserRegisterEntityEntityToJson(
    UserRegisterEntityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['user_id'] = entity.userId;
  data['api_token'] = entity.apiToken;
  return data;
}

extension UserRegisterEntityEntityExtension on UserRegisterEntityEntity {
  UserRegisterEntityEntity copyWith({
    String? message,
    int? status,
    int? userId,
    String? apiToken,
  }) {
    return UserRegisterEntityEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..userId = userId ?? this.userId
      ..apiToken = apiToken ?? this.apiToken;
  }
}