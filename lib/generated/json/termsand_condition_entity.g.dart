import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/termsand_condition_entity.dart';

TermsandConditionEntity $TermsandConditionEntityFromJson(
    Map<String, dynamic> json) {
  final TermsandConditionEntity termsandConditionEntity = TermsandConditionEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    termsandConditionEntity.status = status;
  }
  final String? policy = jsonConvert.convert<String>(json['policy']);
  if (policy != null) {
    termsandConditionEntity.policy = policy;
  }
  return termsandConditionEntity;
}

Map<String, dynamic> $TermsandConditionEntityToJson(
    TermsandConditionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['policy'] = entity.policy;
  return data;
}

extension TermsandConditionEntityExtension on TermsandConditionEntity {
  TermsandConditionEntity copyWith({
    int? status,
    String? policy,
  }) {
    return TermsandConditionEntity()
      ..status = status ?? this.status
      ..policy = policy ?? this.policy;
  }
}