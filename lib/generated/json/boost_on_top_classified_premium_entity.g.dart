import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/boost_on_top_classified_premium_entity.dart';

BoostOnTopClassifiedPremiumEntity $BoostOnTopClassifiedPremiumEntityFromJson(
    Map<String, dynamic> json) {
  final BoostOnTopClassifiedPremiumEntity boostOnTopClassifiedPremiumEntity = BoostOnTopClassifiedPremiumEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    boostOnTopClassifiedPremiumEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    boostOnTopClassifiedPremiumEntity.message = message;
  }
  return boostOnTopClassifiedPremiumEntity;
}

Map<String, dynamic> $BoostOnTopClassifiedPremiumEntityToJson(
    BoostOnTopClassifiedPremiumEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BoostOnTopClassifiedPremiumEntityExtension on BoostOnTopClassifiedPremiumEntity {
  BoostOnTopClassifiedPremiumEntity copyWith({
    int? status,
    String? message,
  }) {
    return BoostOnTopClassifiedPremiumEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}