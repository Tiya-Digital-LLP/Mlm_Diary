import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_phone_verify_otp_entity.dart';

UpdatePhoneVerifyOtpEntity $UpdatePhoneVerifyOtpEntityFromJson(
    Map<String, dynamic> json) {
  final UpdatePhoneVerifyOtpEntity updatePhoneVerifyOtpEntity = UpdatePhoneVerifyOtpEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updatePhoneVerifyOtpEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updatePhoneVerifyOtpEntity.message = message;
  }
  return updatePhoneVerifyOtpEntity;
}

Map<String, dynamic> $UpdatePhoneVerifyOtpEntityToJson(
    UpdatePhoneVerifyOtpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension UpdatePhoneVerifyOtpEntityExtension on UpdatePhoneVerifyOtpEntity {
  UpdatePhoneVerifyOtpEntity copyWith({
    int? status,
    String? message,
  }) {
    return UpdatePhoneVerifyOtpEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}