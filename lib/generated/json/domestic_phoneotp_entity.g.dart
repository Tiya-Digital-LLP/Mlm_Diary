import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/domestic_phoneotp_entity.dart';

DomesticPhoneotpEntity $DomesticPhoneotpEntityFromJson(
    Map<String, dynamic> json) {
  final DomesticPhoneotpEntity domesticPhoneotpEntity = DomesticPhoneotpEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    domesticPhoneotpEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    domesticPhoneotpEntity.status = status;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    domesticPhoneotpEntity.userId = userId;
  }
  return domesticPhoneotpEntity;
}

Map<String, dynamic> $DomesticPhoneotpEntityToJson(
    DomesticPhoneotpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['user_id'] = entity.userId;
  return data;
}

extension DomesticPhoneotpEntityExtension on DomesticPhoneotpEntity {
  DomesticPhoneotpEntity copyWith({
    String? message,
    int? status,
    int? userId,
  }) {
    return DomesticPhoneotpEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..userId = userId ?? this.userId;
  }
}