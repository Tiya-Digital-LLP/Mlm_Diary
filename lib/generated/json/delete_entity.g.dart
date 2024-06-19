import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/delete_entity.dart';

DeleteEntity $DeleteEntityFromJson(Map<String, dynamic> json) {
  final DeleteEntity deleteEntity = DeleteEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    deleteEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    deleteEntity.message = message;
  }
  final String? apiToken = jsonConvert.convert<String>(json['api_token']);
  if (apiToken != null) {
    deleteEntity.apiToken = apiToken;
  }
  final bool? redirectToCompany = jsonConvert.convert<bool>(
      json['redirect_to_company']);
  if (redirectToCompany != null) {
    deleteEntity.redirectToCompany = redirectToCompany;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    deleteEntity.userId = userId;
  }
  return deleteEntity;
}

Map<String, dynamic> $DeleteEntityToJson(DeleteEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  data['api_token'] = entity.apiToken;
  data['redirect_to_company'] = entity.redirectToCompany;
  data['user_id'] = entity.userId;
  return data;
}

extension DeleteEntityExtension on DeleteEntity {
  DeleteEntity copyWith({
    int? result,
    String? message,
    String? apiToken,
    bool? redirectToCompany,
    int? userId,
  }) {
    return DeleteEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message
      ..apiToken = apiToken ?? this.apiToken
      ..redirectToCompany = redirectToCompany ?? this.redirectToCompany
      ..userId = userId ?? this.userId;
  }
}