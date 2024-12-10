import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/delete_account_entity.dart';

DeleteAccountEntity $DeleteAccountEntityFromJson(Map<String, dynamic> json) {
  final DeleteAccountEntity deleteAccountEntity = DeleteAccountEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    deleteAccountEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    deleteAccountEntity.message = message;
  }
  return deleteAccountEntity;
}

Map<String, dynamic> $DeleteAccountEntityToJson(DeleteAccountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension DeleteAccountEntityExtension on DeleteAccountEntity {
  DeleteAccountEntity copyWith({
    int? status,
    String? message,
  }) {
    return DeleteAccountEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}