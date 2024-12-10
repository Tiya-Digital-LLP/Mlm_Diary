import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/verify_phone_otp_entity.dart';

VerifyPhoneOtpEntity $VerifyPhoneOtpEntityFromJson(Map<String, dynamic> json) {
  final VerifyPhoneOtpEntity verifyPhoneOtpEntity = VerifyPhoneOtpEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    verifyPhoneOtpEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    verifyPhoneOtpEntity.status = status;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    verifyPhoneOtpEntity.userId = userId;
  }
  return verifyPhoneOtpEntity;
}

Map<String, dynamic> $VerifyPhoneOtpEntityToJson(VerifyPhoneOtpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['user_id'] = entity.userId;
  return data;
}

extension VerifyPhoneOtpEntityExtension on VerifyPhoneOtpEntity {
  VerifyPhoneOtpEntity copyWith({
    String? message,
    int? status,
    int? userId,
  }) {
    return VerifyPhoneOtpEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..userId = userId ?? this.userId;
  }
}