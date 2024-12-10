import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/forgot_password_entity.dart';

ForgotPasswordEntity $ForgotPasswordEntityFromJson(Map<String, dynamic> json) {
  final ForgotPasswordEntity forgotPasswordEntity = ForgotPasswordEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    forgotPasswordEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    forgotPasswordEntity.message = message;
  }
  final int? userOtp = jsonConvert.convert<int>(json['user_otp']);
  if (userOtp != null) {
    forgotPasswordEntity.userOtp = userOtp;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    forgotPasswordEntity.userId = userId;
  }
  return forgotPasswordEntity;
}

Map<String, dynamic> $ForgotPasswordEntityToJson(ForgotPasswordEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  data['user_otp'] = entity.userOtp;
  data['user_id'] = entity.userId;
  return data;
}

extension ForgotPasswordEntityExtension on ForgotPasswordEntity {
  ForgotPasswordEntity copyWith({
    int? result,
    String? message,
    int? userOtp,
    int? userId,
  }) {
    return ForgotPasswordEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message
      ..userOtp = userOtp ?? this.userOtp
      ..userId = userId ?? this.userId;
  }
}