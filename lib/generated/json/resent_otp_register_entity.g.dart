import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/resent_otp_register_entity.dart';

ResentOtpRegisterEntity $ResentOtpRegisterEntityFromJson(
    Map<String, dynamic> json) {
  final ResentOtpRegisterEntity resentOtpRegisterEntity = ResentOtpRegisterEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    resentOtpRegisterEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    resentOtpRegisterEntity.status = status;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    resentOtpRegisterEntity.userId = userId;
  }
  return resentOtpRegisterEntity;
}

Map<String, dynamic> $ResentOtpRegisterEntityToJson(
    ResentOtpRegisterEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['user_id'] = entity.userId;
  return data;
}

extension ResentOtpRegisterEntityExtension on ResentOtpRegisterEntity {
  ResentOtpRegisterEntity copyWith({
    String? message,
    int? status,
    int? userId,
  }) {
    return ResentOtpRegisterEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..userId = userId ?? this.userId;
  }
}