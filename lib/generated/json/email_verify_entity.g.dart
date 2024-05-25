import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/email_verify_entity.dart';

EmailVerifyEntity $EmailVerifyEntityFromJson(Map<String, dynamic> json) {
  final EmailVerifyEntity emailVerifyEntity = EmailVerifyEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    emailVerifyEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    emailVerifyEntity.status = status;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    emailVerifyEntity.userId = userId;
  }
  return emailVerifyEntity;
}

Map<String, dynamic> $EmailVerifyEntityToJson(EmailVerifyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['user_id'] = entity.userId;
  return data;
}

extension EmailVerifyEntityExtension on EmailVerifyEntity {
  EmailVerifyEntity copyWith({
    String? message,
    int? status,
    int? userId,
  }) {
    return EmailVerifyEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..userId = userId ?? this.userId;
  }
}