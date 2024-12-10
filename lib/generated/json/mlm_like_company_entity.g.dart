import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/mlm_like_company_entity.dart';

MlmLikeCompanyEntity $MlmLikeCompanyEntityFromJson(Map<String, dynamic> json) {
  final MlmLikeCompanyEntity mlmLikeCompanyEntity = MlmLikeCompanyEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    mlmLikeCompanyEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    mlmLikeCompanyEntity.message = message;
  }
  return mlmLikeCompanyEntity;
}

Map<String, dynamic> $MlmLikeCompanyEntityToJson(MlmLikeCompanyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension MlmLikeCompanyEntityExtension on MlmLikeCompanyEntity {
  MlmLikeCompanyEntity copyWith({
    int? status,
    String? message,
  }) {
    return MlmLikeCompanyEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}