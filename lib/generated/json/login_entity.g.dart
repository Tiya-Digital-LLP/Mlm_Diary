import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    loginEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    loginEntity.message = message;
  }
  final String? apiToken = jsonConvert.convert<String>(json['api_token']);
  if (apiToken != null) {
    loginEntity.apiToken = apiToken;
  }
  final bool? redirectToCompany = jsonConvert.convert<bool>(
      json['redirect_to_company']);
  if (redirectToCompany != null) {
    loginEntity.redirectToCompany = redirectToCompany;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  data['api_token'] = entity.apiToken;
  data['redirect_to_company'] = entity.redirectToCompany;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    int? result,
    String? message,
    String? apiToken,
    bool? redirectToCompany,
  }) {
    return LoginEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message
      ..apiToken = apiToken ?? this.apiToken
      ..redirectToCompany = redirectToCompany ?? this.redirectToCompany;
  }
}