import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/email_otp_entity.dart';

EmailOtpEntity $EmailOtpEntityFromJson(Map<String, dynamic> json) {
  final EmailOtpEntity emailOtpEntity = EmailOtpEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    emailOtpEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    emailOtpEntity.status = status;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    emailOtpEntity.userId = userId;
  }
  return emailOtpEntity;
}

Map<String, dynamic> $EmailOtpEntityToJson(EmailOtpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['user_id'] = entity.userId;
  return data;
}

extension EmailOtpEntityExtension on EmailOtpEntity {
  EmailOtpEntity copyWith({
    String? message,
    int? status,
    int? userId,
  }) {
    return EmailOtpEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..userId = userId ?? this.userId;
  }
}