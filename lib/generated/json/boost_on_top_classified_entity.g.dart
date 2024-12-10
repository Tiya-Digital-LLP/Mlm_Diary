import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/boost_on_top_classified_entity.dart';

BoostOnTopClassifiedEntity $BoostOnTopClassifiedEntityFromJson(
    Map<String, dynamic> json) {
  final BoostOnTopClassifiedEntity boostOnTopClassifiedEntity = BoostOnTopClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    boostOnTopClassifiedEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    boostOnTopClassifiedEntity.message = message;
  }
  return boostOnTopClassifiedEntity;
}

Map<String, dynamic> $BoostOnTopClassifiedEntityToJson(
    BoostOnTopClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BoostOnTopClassifiedEntityExtension on BoostOnTopClassifiedEntity {
  BoostOnTopClassifiedEntity copyWith({
    int? status,
    String? message,
  }) {
    return BoostOnTopClassifiedEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}