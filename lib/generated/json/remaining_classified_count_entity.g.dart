import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/remaining_classified_count_entity.dart';

RemainingClassifiedCountEntity $RemainingClassifiedCountEntityFromJson(
    Map<String, dynamic> json) {
  final RemainingClassifiedCountEntity remainingClassifiedCountEntity = RemainingClassifiedCountEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    remainingClassifiedCountEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    remainingClassifiedCountEntity.message = message;
  }
  return remainingClassifiedCountEntity;
}

Map<String, dynamic> $RemainingClassifiedCountEntityToJson(
    RemainingClassifiedCountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension RemainingClassifiedCountEntityExtension on RemainingClassifiedCountEntity {
  RemainingClassifiedCountEntity copyWith({
    int? status,
    String? message,
  }) {
    return RemainingClassifiedCountEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}