import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/email_verify_otp_entity.dart';

EmailVerifyOtpEntity $EmailVerifyOtpEntityFromJson(Map<String, dynamic> json) {
  final EmailVerifyOtpEntity emailVerifyOtpEntity = EmailVerifyOtpEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    emailVerifyOtpEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    emailVerifyOtpEntity.message = message;
  }
  return emailVerifyOtpEntity;
}

Map<String, dynamic> $EmailVerifyOtpEntityToJson(EmailVerifyOtpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  return data;
}

extension EmailVerifyOtpEntityExtension on EmailVerifyOtpEntity {
  EmailVerifyOtpEntity copyWith({
    int? result,
    String? message,
  }) {
    return EmailVerifyOtpEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message;
  }
}