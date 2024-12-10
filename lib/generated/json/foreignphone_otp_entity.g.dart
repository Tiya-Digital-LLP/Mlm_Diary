import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/foreignphone_otp_entity.dart';

ForeignphoneOtpEntity $ForeignphoneOtpEntityFromJson(
    Map<String, dynamic> json) {
  final ForeignphoneOtpEntity foreignphoneOtpEntity = ForeignphoneOtpEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    foreignphoneOtpEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    foreignphoneOtpEntity.status = status;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    foreignphoneOtpEntity.userId = userId;
  }
  return foreignphoneOtpEntity;
}

Map<String, dynamic> $ForeignphoneOtpEntityToJson(
    ForeignphoneOtpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['user_id'] = entity.userId;
  return data;
}

extension ForeignphoneOtpEntityExtension on ForeignphoneOtpEntity {
  ForeignphoneOtpEntity copyWith({
    String? message,
    int? status,
    int? userId,
  }) {
    return ForeignphoneOtpEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..userId = userId ?? this.userId;
  }
}